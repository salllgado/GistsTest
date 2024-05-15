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
            case let .failure(error):
                self.delegate?.displayError(message: error.localizedDescription)
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
            case let .failure(error):
                self.delegate?.displayError(message: error.localizedDescription)
            }
        }
    }
    
    private func requestGists(page: Int = 1, limit: Int = 30, completion: @escaping (Result<[Gist], NetworkError>) -> Void) {
        NetworkServiceProvider.shared.request(
            target: GistsAPI.getGistsFromRemote(
                page: page,
                limit: limit
            )
        ) { result in
            completion(.success(result))
        } failure: { error in
            completion(.failure(error))
        }
    }
}

