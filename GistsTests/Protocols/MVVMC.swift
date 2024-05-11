//
//  MVVMC.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import Foundation

protocol MVVMC: AnyObject {
    associatedtype T: ViewModel
    associatedtype U: Coordinator
    var vm: T { get }
    var coordinator: U? { get }
    init()
}

protocol ViewModel: AnyObject {
    init()
}
