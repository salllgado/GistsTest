//
//  GistListController.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import UIKit

final class GistListViewController: UIViewController {

    weak var customView: GistListViewProtocol?

    private var viewModel: GistListViewModable
    private var coordinator: GistListCoordinating

    init(viewModel: GistListViewModable, coordinator: GistListCoordinating) {
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
        view = GistListView(actions: .init(didSelectGist: { [weak self] gist in
            self?.coordinator.navigateToDetail(gist: gist)
        }))
        customView = view as? GistListViewProtocol
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: - private methods

    private func loadData() {
        viewModel.fetchData()
    }
}

extension GistListViewController: GistListDelegate {
    func displayData(gists: [Gist]) {
        customView?.displayData(gists)
    }
    
    func displayError(message: String) {
        // display toast
    }
}
