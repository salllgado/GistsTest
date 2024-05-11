//
//  GistListView.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import UIKit
import Hero

protocol GistListViewProtocol: UIView {
    func displayData(_ itens: [Any])
}

struct Gist {
    let backgroundColor: UIColor
}

final class GistListView: UIView, BaseView, GistListViewProtocol {
    
    struct Actions {
        let didSelectGist: (_ gist: Gist) -> Void
    }
    
    private var actions: Actions?
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelection = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private var itens: [Any] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Initializers
    
    init(actions: Actions) {
        self.actions = actions
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
        hero.modifiers = [.fade]
    }
    
    // MARK: - GistListViewProtocol
    
    func displayData(_ itens: [Any]) {
        self.itens = itens
    }
    
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension GistListView: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = [.red, .black].randomElement()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.cellForRow(at: indexPath)?.hero.id = "backgroundColorAnimated"
        actions?.didSelectGist(.init(backgroundColor: tableView.cellForRow(at: indexPath)?.backgroundColor ?? .white))
    }
}
