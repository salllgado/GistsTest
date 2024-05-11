//
//  GistListController.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import UIKit
import Hero

final class GistListViewController: MVVMViewController<GistListViewModel, ApplicationCoordinator> {
    
    weak var customView: GistListViewProtocol?
    
    override func loadView() {
        super.loadView()
        view = GistListView(actions: .init(didSelectGist: { [weak self] gist in
            self?.coordinator?.navigateToDetail(gist: gist)
        }))
        customView = view as? GistListViewProtocol
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView?.displayData([1, 2, 3, 4, 5])
    }
}
