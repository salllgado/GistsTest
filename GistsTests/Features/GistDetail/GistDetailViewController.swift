//
//  GistDetailViewController.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import UIKit

final class GistDetailViewController: UIViewController{
    
    private var viewModel: GistDetailViewModable
    
    init(viewModel: GistDetailViewModable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = GistDetailView(gist: viewModel.gist.toGistSimplified())
        hero.isEnabled = true
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gist of"
        
    }
}
