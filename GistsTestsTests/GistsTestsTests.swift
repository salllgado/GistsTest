//
//  ApplicationCoordinatorTests.swift
//  GistsTestsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import XCTest
@testable import GistsTests

final class ApplicationCoordinatorTests: XCTestCase {
    final class UINavigationControllerSpy: UINavigationController {
        
        private(set) var pushViewControllerCalledCount: Int = 0
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushViewControllerCalledCount += 1
            super.pushViewController(viewController, animated: false)
        }
    }

    func testOnStartShouldAppendGistsListViewController() {
        // Given
        let spy = UINavigationControllerSpy()
        let sut = ApplicationCoordinator(window: nil, context: spy)
        
        // When
        sut.start()
        
        // Than
        XCTAssertEqual(spy.pushViewControllerCalledCount, 1)
        XCTAssertEqual(spy.viewControllers.count, 1)
        if let firstViewController = spy.viewControllers.first {
            XCTAssertTrue(firstViewController.isKind(of: GistListViewController.self))
        }
    }
    
    func testOnNavigateToDetail_shouldAppendDetailViewControllerOnContext() {
        // Given
        let spy = UINavigationControllerSpy()
        spy.setViewControllers([UIViewController()], animated: false)
        let sut = ApplicationCoordinator(window: nil, context: spy)
        
        // When
        sut.navigateToDetail(gist: .fixture())
        
        // Than
        XCTAssertEqual(spy.pushViewControllerCalledCount, 1)
        XCTAssertEqual(spy.viewControllers.count, 2)
        if let viewController = spy.viewControllers.last {
            XCTAssertTrue(viewController.isKind(of: GistDetailViewController.self))
        }
    }
}
