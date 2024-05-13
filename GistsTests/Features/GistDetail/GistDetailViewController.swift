//
//  GistDetailViewController.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import UIKit
import Hero

final class GistDetailViewController: UIViewController{
    
    private var viewModel: GistDetailViewModable

    init(viewModel: GistDetailViewModable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var circularView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 44).isActive = true
        view.widthAnchor.constraint(equalToConstant: 44).isActive = true
        view.hero.id = "backgroundColorAnimated"
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(circularView)
        
        NSLayoutConstraint.activate([
            circularView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circularView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        hero.isEnabled = true
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalhes"
        
//        circularView.backgroundColor = viewModel.gist.
    }
}
