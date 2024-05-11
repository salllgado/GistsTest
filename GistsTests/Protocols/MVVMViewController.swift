//
//  MVVMViewController.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import UIKit

class MVVMViewController<T: ViewModel, U: Coordinator>: UIViewController, MVVMC {
 
    typealias T = T
    typealias U = U
    var vm: T
    var coordinator: U?

    required init(_ viewModel: T, _ _coordinator: U) {
        vm = viewModel
        coordinator = _coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init() {
        vm = .init()
        coordinator = nil
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        vm = .init()
        super.init(coder: aDecoder)
    }
}
