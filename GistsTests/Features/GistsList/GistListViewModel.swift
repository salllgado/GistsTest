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
}

final class GistListViewModel: GistListViewModable, TableViewPagination {
    
    var currentPage: Int = 1
    var numberOfPages: Int = 1
    var hasNextPage: Bool = true
    var shouldShowLoadingCell: Bool = true
    
    weak var delegate: GistListDelegate?
    private var gists: [Gist] = []
    
    func fetchData() {
        requestGists { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(success):
                self.gists = success
                self.delegate?.displayData(gists: self.gists)
            case .failure:
                self.delegate?.displayError(message: "Some error from api or parsing")
            }
        }
    }
    
    func loadingNextPage() {
        requestGists(page: currentPage + 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(success):
                self.currentPage += 1
                self.gists += success
                self.delegate?.displayData(gists: self.gists)
            case .failure:
                break
            }
        }
    }
    
    private func requestGists(page: Int = 1, limit: Int = 30, completion: @escaping (Result<[Gist], NetworkError>) -> Void) {
        NetworkServiceProvider.shared.request(target: GistsAPI.getGistsFromRemote(page: page, limit: limit)) { result in
            completion(.success(result))
        } failure: { error in
            completion(.failure(error))
        }
    }
}

