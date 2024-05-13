//
//  NetworkServiceProvider.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 13/05/24.
//

import Foundation

enum LocalyJsons: String {
    case GistListFakeJson
}

enum Source {
    case remote
    case localy
}

enum NetworkError: Error {
    case badURL
    case connectionFailure(Error)
    case noData
    case parseError(Error)
    case errorByStatusCode(Int)
}

final class NetworkServiceProvider {
    
    private(set) var session: URLSession
    static var shared = NetworkServiceProvider()
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(
        target: NetworkServiceTargetProtocol,
        success: @escaping ((_ result: T) -> Void),
        failure: @escaping (_ error: NetworkError) -> Void
    ) {
        switch target.source {
        case .remote:
            self.requestDataFromRemote(target: target, success: success, failure: failure)
        case .localy:
            self.requestDataLocaly(jsonName: target.path, success: success, failure: failure)
        }
    }
    
    private func requestDataLocaly<T: Decodable>(
        jsonName: String,
        success: @escaping ((_ result: T) -> Void),
        failure: @escaping (_ error: NetworkError) -> Void
    ) {
        if let path = Bundle.main.path(forResource: jsonName, ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url)
                
                self.parseData(data: data, success: success, failure: failure)
            } catch {
                failure(.parseError(error))
            }
        }
    }
    
    private func requestDataFromRemote<T: Decodable>(
        target: NetworkServiceTargetProtocol,
        success: @escaping ((_ result: T) -> Void),
        failure: @escaping (_ error: NetworkError) -> Void
    ) {
        guard let url = target.baseURL?.appendingPathComponent(target.path) else {
            failure(.badURL)
            return
        }
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            failure(.badURL)
            return
        }
        
        urlComponents.queryItems = target.parameters.map({ URLQueryItem(name: $0.key, value: $0.value) })
        
        guard let componentURL = urlComponents.url else {
            failure(.badURL)
            return
        }
        
        var urlRequest = URLRequest(url: componentURL)
        urlRequest.httpMethod = target.method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let sessionid = target.sessionId {
            urlRequest.addValue(sessionid, forHTTPHeaderField: "Vidalink-Session-Id")
        }
        
        if target.shouldUseAccessToken.0, let token = target.shouldUseAccessToken.1 {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        addAdditionalHeaders(target.additionalHeaders, request: &urlRequest)
        
        if target.method != .GET {
            do {
                let body = try JSONSerialization.data(withJSONObject: target.body, options: .prettyPrinted)
                urlRequest.httpBody = body
            } catch {
                
            }
        }
        
        let session = self.session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
#if DEBUG
                self?.debugResponse(request: urlRequest, data: data)
#endif
                
                if let error = error {
                    failure(.connectionFailure(error))
                } else {
                    self?.parseData(data: data, success: success, failure: failure)
                }
            }
        }
        
        session.resume()
    }
    
    private func parseData<T: Decodable>(
        data: Data?,
        success: @escaping ((_ result: T) -> Void),
        failure: @escaping (_ error: NetworkError) -> Void
    ) {
        guard let data = data else {
            failure(.noData)
            return
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            success(decoded)
        } catch(let error) {
#if DEBUG
            print(error)
#endif
            failure(.parseError(error))
        }
    }
}

extension NetworkServiceProvider {
    private func addAdditionalHeaders(_ additionalHeaders: [String: String]?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

extension NetworkServiceProvider {
    
#if DEBUG
    func debugResponse(request: URLRequest, data: Data?) {
        print("==== REQUEST ====")
        print("\nURL: \(request.url?.absoluteString ?? "")")
        
        if let requestHeader = request.allHTTPHeaderFields {
            if let data = try? JSONSerialization.data(withJSONObject: requestHeader, options: .prettyPrinted) {
                print("\nHEADER: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }
        
        if let httpBody = request.httpBody {
            print("\nBODY: \(String(data: httpBody, encoding: .utf8) ?? "")")
        }
        
        print("\nMETHOD: \(request.httpMethod ?? "")")
        
        print("\n==== RESPONSE ====")
        if let data = data {
            if let jsonObject = try? JSONSerialization.jsonObject(with: data) {
                if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
                    print(String(data: jsonData, encoding: .utf8) ?? "")
                }
            }
        }
        print("\n================\n")
    }
#endif
}
