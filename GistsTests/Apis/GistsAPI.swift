//
//  GistsAPI.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 14/05/24.
//

import Foundation

enum GistsAPI: NetworkServiceTargetProtocol {
    case getGistsFromRemote(page: Int, limit: Int)
    case getGistsFromLocal
    
    var baseURL: URL? {
        switch self {
        case .getGistsFromRemote:
            guard let baseURLString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
                return nil
            }
            return .init(string: "https://" + baseURLString)
        case .getGistsFromLocal:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .getGistsFromRemote:
            return "/gists/public"
        case .getGistsFromLocal:
            return LocalyJsons.GistListFakeJson.rawValue
        }
    }
    
    var method: VLNetworkHTTPMethod {
        .GET
    }
    
    var parameters: [String : String] {
        switch self {
        case let .getGistsFromRemote(page, limit):
            return [
                "page": String(page),
                "limit": String(limit)
            ]
        case .getGistsFromLocal:
            return [:]
        }
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var shouldUseAccessToken: (Bool, String?) {
        return (true, Bundle.main.object(forInfoDictionaryKey: "AUTH_TOKEN") as? String)
    }
    
    var source: Source {
        switch self {
        case .getGistsFromRemote:
            return .remote
        case .getGistsFromLocal:
            return .localy
        }
    }
    
    var strategy: JSONDecoder.KeyDecodingStrategy {
        return .convertFromSnakeCase
    }
}
