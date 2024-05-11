//
//  Coordinator.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import UIKit

protocol Coordinator where Self: AnyObject {
    var context: UINavigationController { get }
    
    func start()
}
