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
    
    var currentPage: Int
    var numberOfPages: Int
    var hasNextPage: Bool
    var shouldShowLoadingCell: Bool
    
    let limit: Int
    
    weak var delegate: GistListDelegate?
    private var gists: [Gist] = []
    
    private var requestManager: GistListRequestManagerProtocol
    
    init(
        requestManager: GistListRequestManagerProtocol,
        currentPage: Int = 1,
        numberOfPages: Int = 1,
        hasNextPage: Bool = true,
        shouldShowLoadingCell: Bool = true,
        limit: Int = 30
    ) {
        self.requestManager = requestManager
        self.currentPage = currentPage
        self.numberOfPages = numberOfPages
        self.hasNextPage = hasNextPage
        self.shouldShowLoadingCell = shouldShowLoadingCell
        self.limit = limit
    }
    
    func fetchData() {
        requestManager.requestGists(page: 1, limit: limit) { [weak self] result in
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
        requestManager.requestGists(page: currentPage + 1, limit: limit) { [weak self] result in
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
}

