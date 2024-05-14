//
//  GistListController.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import UIKit
import Toast

protocol GistListPaginationDataSource {
    func canSetLoading(when indexPath: IndexPath, reach value: Int) -> Bool
    func isLoadingIndexPath(_ indexPath: IndexPath, reach value: Int) -> Bool
    func hasNextPage() -> Bool
}

protocol GistListPaginationDelegate {
    func loadingNextPage()
}

final class GistListViewController: UIViewController {
    
    typealias GistListViewModelProtocol = (GistListViewModable & TableViewPagination)

    weak var customView: GistListViewProtocol?

    private var viewModel: GistListViewModelProtocol
    private var coordinator: GistListCoordinating
    
    private var style = ToastStyle()

    init(viewModel: GistListViewModelProtocol, coordinator: GistListCoordinating) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = GistListView(
            actions: .init(
                didSelectGist: { [weak self] gist in
                self?.coordinator.navigateToDetail(gist: gist)
            }),
            paginationDataSource: self,
            paginationDelegate: self
        )
        customView = view as? GistListViewProtocol
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gists"
        loadData()
        setupElements()
    }
    
    // MARK: - private methods
    private func setupElements() {
        style.messageColor = .white
    }

    private func loadData() {
        viewModel.fetchData()
    }
}

extension GistListViewController: GistListDelegate {
    func displayData(gists: [Gist]) {
        customView?.displayData(gists)
    }
    
    func displayError(message: String) {
        view.makeToast(message, duration: 1.5, position: .bottom, style: style)
    }
}

extension GistListViewController: GistListPaginationDataSource, GistListPaginationDelegate {
    func hasNextPage() -> Bool {
        viewModel.hasNextPage
    }
    
    func canSetLoading(when indexPath: IndexPath, reach value: Int) -> Bool {
        viewModel.canSetLoading(when: indexPath, reach: value)
    }
    
    func isLoadingIndexPath(_ indexPath: IndexPath, reach value: Int) -> Bool {
        viewModel.isLoadingIndexPath(indexPath, reach: value)
    }
    
    func loadingNextPage() {
        viewModel.loadingNextPage()
    }
}
