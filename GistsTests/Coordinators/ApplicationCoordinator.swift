//
//  ApplicationCoordinator.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import UIKit
import Hero

protocol GistListCoordinating {
    func navigateToDetail(gist: Gist)
}

final class ApplicationCoordinator: Coordinator {
        
    let window: UIWindow?
    let context: UINavigationController
    
    init(window: UIWindow?, context: UINavigationController = .init()) {
        self.window = window
        self.context = context
        self.context.navigationBar.prefersLargeTitles = true
        self.context.isHeroEnabled = true
        self.context.hero.navigationAnimationType = .none
    }
    
    func start() {
        let vm = GistListViewModel()
        let vc = GistListViewController(viewModel: vm, coordinator: self)
        context.pushViewController(vc, animated: false)
        window?.rootViewController = context
        window?.makeKeyAndVisible()
    }
    
}

extension ApplicationCoordinator: GistListCoordinating {
    
    func navigateToDetail(gist: Gist) {
        let viewModel = GistDetailViewModel(gist: gist)
        context.pushViewController(
            GistDetailViewController(viewModel: viewModel),
            animated: true
        )
    }
}
