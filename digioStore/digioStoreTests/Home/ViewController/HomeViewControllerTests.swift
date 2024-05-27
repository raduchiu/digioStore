//
//  HomeVIewModelTests.swift
//  digioStoreTests
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import Foundation
import XCTest
@testable import digioStore

class HomeViewControllerTests: XCTestCase {

    var homeViewController: HomeViewController!
    var viewModel: HomeViewModelMock!

    override func setUp() {
        super.setUp()
        let mockResponse = LoadDataHelper.shared.parseMockResponseData(LoadDataHelper.shared.loadMockResponseData()!)!
        let mockProductService = MockProductService(mockResponse: .success(mockResponse))
        viewModel = HomeViewModelMock(productService: mockProductService)
        homeViewController = HomeViewController(viewModel: viewModel)

        // Load the view hierarchy
        _ = homeViewController.view
    }

    override func tearDown() {
        viewModel = nil
        homeViewController = nil

        super.tearDown()
    }

    func testViewController_WhenViewIsLoaded_HasWelcomeLabel() {
        XCTAssertNotNil(homeViewController.welcomeLabel)
    }

    func testViewController_WhenViewIsLoaded_HasSpotlightCarousel() {
        XCTAssertNotNil(homeViewController.spotlightCarousel)
    }

    func testViewController_WhenViewIsLoaded_HasCashLabel() {
        XCTAssertNotNil(homeViewController.cashLabel)
    }

    func testViewController_WhenViewIsLoaded_HasBannerImageView() {
        XCTAssertNotNil(homeViewController.bannerImageView)
    }

    func testViewController_WhenViewIsLoaded_HasProductsLabel() {
        XCTAssertNotNil(homeViewController.productsLabel)
    }

    func testViewController_WhenViewIsLoaded_HasProductsCarousel() {
        XCTAssertNotNil(homeViewController.productsCarousel)
    }

    func testViewController_WhenViewIsLoaded_HasLoadingIndicator() {
        XCTAssertNotNil(homeViewController.loadingIndicator)
    }

    func testViewController_WhenViewIsLoaded_ViewModelFetchProductsCalled() {
        XCTAssertTrue(viewModel.fetchProductsCalled)
    }

    func testViewController_WhenLoadingStatusIsUpdated_StopAnimatingCalled() {
        viewModel.updateLoadingStatus?(true)
        XCTAssertFalse(homeViewController.loadingIndicator.isAnimating)

        viewModel.updateLoadingStatus?(false)
        XCTAssertFalse(homeViewController.loadingIndicator.isAnimating)
    }
}

extension HomeViewControllerTests {
    // Mock class for HomeViewModel
    class HomeViewModelMock: HomeViewModel {

        var fetchProductsCalled = false

        override func fetchProducts() {
            fetchProductsCalled = true
        }
    }

    class MockProductService: ProductService {
        private let mockResponse: Result<StoreResponse, Error>

        init(mockResponse: Result<StoreResponse, Error>) {
            self.mockResponse = mockResponse
        }

        override func fetchProducts(completion: @escaping (Result<StoreResponse, Error>) -> Void) {
            completion(mockResponse)
        }
    }
}
