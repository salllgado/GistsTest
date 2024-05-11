//
//  ApplicationCoordinator.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import UIKit
import Hero

final class ApplicationCoordinator: Coordinator {
        
    let window: UIWindow?
    let context: UINavigationController
    
    init(window: UIWindow?, context: UINavigationController = .init()) {
        self.window = window
        self.context = context
        self.context.isHeroEnabled = true
        self.context.hero.navigationAnimationType = .none
    }
    
    func start() {
        let vm = GistListViewModel()
        let vc = GistListViewController(vm, self)
        context.pushViewController(vc, animated: false)
        window?.rootViewController = context
        window?.makeKeyAndVisible()
    }
    
    func navigateToDetail(gist: Gist) {
        let viewModel = GistDetailViewModel(gist: gist)
        context.pushViewController(
            GistDetailViewController(viewModel, self),
            animated: true
        )
    }
}
