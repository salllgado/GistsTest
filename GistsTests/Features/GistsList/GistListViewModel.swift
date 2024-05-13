//
//  GistListViewModel.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import Foundation

protocol GistListDelegate: AnyObject {
    func displayData(gists: [Gist])
    func displayError(message: String)
}

protocol GistListViewModable: AnyObject {
    var delegate: GistListDelegate? { get set }
    
    func fetchData()
}

enum GistsAPI: NetworkServiceTargetProtocol {
    case getGistsFromRemote
    case getGistsFromLocal
    
    var baseURL: URL? {
        switch self {
        case .getGistsFromRemote:
            fatalError()
        case .getGistsFromLocal:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .getGistsFromRemote:
            fatalError()
        case .getGistsFromLocal:
            return LocalyJsons.GistListFakeJson.rawValue
        }
    }
    
    var method: VLNetworkHTTPMethod {
        .GET
    }
    
    var parameters: [String : String] {
        switch self {
        case .getGistsFromRemote:
            fatalError()
        case .getGistsFromLocal:
            return [:]
        }
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var source: Source {
        switch self {
        case .getGistsFromRemote:
            return .remote
        case .getGistsFromLocal:
            return .localy
        }
    }
}

final class GistListViewModel: GistListViewModable {
    
    weak var delegate: GistListDelegate?
    private var gists: [Gist] = []
    
    func fetchData() {
        requestGists { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(success):
                self.gists += success
                self.delegate?.displayData(gists: self.gists)
            case .failure:
                self.delegate?.displayError(message: "Some error from api or parsing")
            }
        }
    }
    
    func requestGists(completion: @escaping (Result<[Gist], NetworkError>) -> Void) {
        NetworkServiceProvider.shared.request(target: GistsAPI.remote) { result in
            completion(.success(result))
        } failure: { error in
            completion(.failure(error))
        }
    }
}
