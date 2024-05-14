//
//  TableViewPagination.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 13/05/24.
//

import UIKit

protocol TableViewPagination {
    var currentPage: Int { get set }
    var numberOfPages: Int { get set }
    var shouldShowLoadingCell: Bool { get set }
    var hasNextPage: Bool { get }
    
    func canSetLoading(when indexPath: IndexPath, reach value: Int) -> Bool
    func isLoadingIndexPath(_ indexPath: IndexPath, reach value: Int) -> Bool
    func loadingNextPage()
}

extension TableViewPagination {
    
    func canSetLoading(when indexPath: IndexPath, reach value: Int) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.row == value ? true : false
    }
    
    func isLoadingIndexPath(_ indexPath: IndexPath, reach value: Int) -> Bool {
        return shouldShowLoadingCell ? indexPath.row == value : false
    }
}
