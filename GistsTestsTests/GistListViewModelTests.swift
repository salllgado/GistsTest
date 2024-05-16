//
//  GistListViewModelTests.swift
//  GistsTestsTests
//
//  Created by Chrystian Salgado on 15/05/24.
//

import XCTest
@testable import GistsTests

final class GistListViewModelTests: XCTestCase {
    
    final class GistListRequestManagerSpy: GistListRequestManagerProtocol {

        private(set) var requestGistsCalledCount: Int = 0
        private(set) var requestGistsPageWasPassed: Int?
        private(set) var requestGistsLimitWasPassed: Int?
        func requestGists(
                page: Int,
                limit: Int,
                completion: @escaping (Result<[Gist], NetworkError>
            ) -> Void
        ) {
            requestGistsCalledCount += 1
            requestGistsPageWasPassed = page
            requestGistsLimitWasPassed = limit
            
        }
    }
    
    final class GistListControllerSpy: GistListDelegate {
        
        private(set) var displayDataCalledCount: Int = 0
        private(set) var displayDataGistsWasPassed: [Gist]?
        func displayData(gists: [Gist]) {
            displayDataCalledCount += 1
            displayDataGistsWasPassed = gists
        }
        
        private(set) var displayErrorCalledCount: Int = 0
        private(set) var displayErrorMessageWasPassed: String?
        func displayError(message: String) {
            displayErrorCalledCount += 1
            displayErrorMessageWasPassed = message
        }
    }
    
    final class GistListRequestManagerMock: GistListRequestManagerProtocol {
        let result: (Result<[Gist], NetworkError>)
        
        init(result: Result<[Gist], NetworkError>) {
            self.result = result
        }
        
        func requestGists(page: Int, limit: Int, completion: @escaping (Result<[Gist], NetworkError>) -> Void) {
            completion(result)
        }
    }

    func test_onFetchData_shouldRequestPage1WithLimitParametizer() {
        // Given
        let limit = 20
        let spy = GistListRequestManagerSpy()
        let sut = GistListViewModel(requestManager: spy, limit: limit)
        
        // When
        sut.fetchData()
        
        // Than
        XCTAssertEqual(spy.requestGistsCalledCount, 1)
        XCTAssertEqual(spy.requestGistsLimitWasPassed, limit)
        XCTAssertEqual(spy.requestGistsPageWasPassed, 1)
    }

    func test_onLoadingNextPage_shouldRequestNextPage_withLimitParametizer() {
        // Given
        let limit = 15
        let currentPage: Int = 2
        let spy = GistListRequestManagerSpy()
        let sut = GistListViewModel(requestManager: spy, currentPage: currentPage, limit: limit)
        
        // When
        sut.loadingNextPage()
        
        // Than
        XCTAssertEqual(spy.requestGistsCalledCount, 1)
        XCTAssertEqual(spy.requestGistsLimitWasPassed, limit)
        XCTAssertEqual(spy.requestGistsPageWasPassed, currentPage + 1)
    }
    
    func test_onRequestGistsWithSuccess_shouldDisplayData() {
        // Given
        let gists = [Gist.fixture()]
        let mock = GistListRequestManagerMock(result: .success(gists))
        let spy = GistListControllerSpy()
        
        // When
        let sut = GistListViewModel(requestManager: mock)
        sut.delegate = spy
        
        sut.fetchData()
        
        // Than
        XCTAssertEqual(spy.displayDataCalledCount, 1)
        XCTAssertEqual(spy.displayDataGistsWasPassed?.count ?? 0, gists.count) // deveria ser feito por equatable verificando se o array é igual
    }
    
    func test_onRequestGistsWithFailure_shouldDisplayError() {
        // Given
        let mock = GistListRequestManagerMock(result: .failure(.badURL))
        let spy = GistListControllerSpy()
        
        // When
        let sut = GistListViewModel(requestManager: mock)
        sut.delegate = spy
        
        sut.fetchData()
        
        // Than
        XCTAssertEqual(spy.displayErrorCalledCount, 1)
        XCTAssertEqual(spy.displayErrorMessageWasPassed, NetworkError.badURL.localizedDescription)
        XCTAssertEqual(spy.displayDataCalledCount, 0)
        XCTAssertNil(spy.displayDataGistsWasPassed) // deveria ser feito por equatable verificando se o array é igual
    }
}
