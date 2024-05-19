//
//  GistListViewControllerTests.swift
//  GistsTestsTests
//
//  Created by Chrystian Salgado on 19/05/24.
//

import XCTest
@testable import GistsTests

final class GistListViewControllerTests: XCTestCase {
    
    final class FakeView: UIView, GistListViewProtocol {
        var actions: GistListViewActions?
        var paginationDataSource: GistListPaginationDataSource?
        var paginationDelegate: GistListPaginationDelegate?
        
        func setBindings(
            actions: GistListViewActions,
            paginationDataSource: GistListPaginationDataSource,
            paginationDelegate: GistListPaginationDelegate
        ) {
            self.actions = actions
            self.paginationDataSource = paginationDataSource
            self.paginationDelegate = paginationDelegate
        }
        
        func displayData(_ itens: [Gist]) {
            // ...
        }
        
    }
    
    final class GistListViewModelSpy: GistListViewModelProtocol {
        var delegate: GistListDelegate?
        
        var currentPage: Int = 1
        var numberOfPages: Int = 2
        var shouldShowLoadingCell: Bool = true
        var hasNextPage: Bool = true
        
        private(set) var fetchDataCalledCount: Int = 0
        func fetchData() {
            fetchDataCalledCount += 1
        }
        
        private(set) var loadingNextPageCalledCount: Int = 0
        func loadingNextPage() {
            loadingNextPageCalledCount += 1
        }
    }
    
    final class GistListCoordinatorDummy: GistListCoordinating {
        func navigateToDetail(gist: Gist) {
            
        }
        
    }
    
    func test_onViewdidLoad_shouldLoadData() {
        // Given
        let fakeView = FakeView()
        let spy = GistListViewModelSpy()
        let sut = GistListViewController(view: fakeView, viewModel: spy, coordinator: GistListCoordinatorDummy())
        _ = sut.view
        
        // When // Than
        XCTAssertEqual(spy.fetchDataCalledCount, 1)
        
    }

    func test_onLoadingNextPage_viewModelShouldCalledToRequestNextPage() {
        // Given
        let fakeView = FakeView()
        let spy = GistListViewModelSpy()
        let sut = GistListViewController(view: fakeView, viewModel: spy, coordinator: GistListCoordinatorDummy())
        _ = sut.view
        
        // When
        fakeView.paginationDelegate?.loadingNextPage()
        
        // Than
        XCTAssertEqual(spy.loadingNextPageCalledCount, 1)
    }

}
