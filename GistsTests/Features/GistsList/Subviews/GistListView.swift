//
//  GistListView.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import UIKit
import Hero

struct GistListViewActions {
    let didSelectGist: (_ gist: Gist) -> Void
}

protocol GistListViewProtocol: UIView {
    var actions: GistListViewActions? { get }
    var paginationDataSource: GistListPaginationDataSource? { get }
    var paginationDelegate: GistListPaginationDelegate? { get }
    
    func setBindings(actions: GistListViewActions, paginationDataSource: GistListPaginationDataSource, paginationDelegate: GistListPaginationDelegate)
    func displayData(_ itens: [Gist])
}

final class GistListView: UIView, BaseView, GistListViewProtocol {
    
    private(set) var actions: GistListViewActions?
    private(set) var paginationDataSource: GistListPaginationDataSource?
    private(set) var paginationDelegate: GistListPaginationDelegate?
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelection = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private var itens: [Gist] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        constrainSubviews()
        additionalConfigurationSettings()
    }
    
    init(
//        actions: GistListViewActions,
//        paginationDataSource: GistListPaginationDataSource,
//        paginationDelegate: GistListPaginationDelegate
    ) {
//        self.actions = actions
//        self.paginationDataSource = paginationDataSource
//        self.paginationDelegate = paginationDelegate
        super.init(frame: .zero)
        addSubviews()
        constrainSubviews()
        additionalConfigurationSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - View Configuration
    
    func addSubviews() {
        addSubview(tableView)
    }
    
    func constrainSubviews() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func additionalConfigurationSettings() {
        backgroundColor = .systemBackground
        
        isHeroEnabled = true
        isHeroEnabledForSubviews = true
    }
    
    // MARK: - GistListViewProtocol
    func setBindings(actions: GistListViewActions, paginationDataSource: GistListPaginationDataSource, paginationDelegate: GistListPaginationDelegate) {
        self.actions = actions
        self.paginationDataSource = paginationDataSource
        self.paginationDelegate = paginationDelegate
    }
    
    func displayData(_ itens: [Gist]) {
        self.itens = itens
    }
    
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension GistListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginationDataSource?.hasNextPage() ?? false ? itens.count + 1 : itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if paginationDataSource?.canSetLoading(when: indexPath, reach: itens.count) ?? false {
            return LoadingTableViewCell()
        }
        
        let gist = itens[indexPath.row].toGistSimplified()
        let cell = GistListTableViewCell(gist: gist)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        actions?.didSelectGist(itens[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard paginationDataSource?.isLoadingIndexPath(indexPath, reach: itens.count) ?? false else { return }
        paginationDelegate?.loadingNextPage()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66.0 // I set the value here because it seems that there is a bug in the listing that shows a constraint break by 0.3333333
    }
    
}
