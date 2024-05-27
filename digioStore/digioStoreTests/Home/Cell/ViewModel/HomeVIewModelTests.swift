//
//  HomeVIewModelTests.swift
//  digioStoreTests
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import XCTest
@testable import digioStore

class HomeViewModelTests: XCTestCase {
    
    // MARK: - Test Cases
    
    func testFetchProducts_Success() {
        // Given
        let mockResponse = StoreResponse(
            spotlight: [
                SpotlightItem(
                    name: "Test Spotlight",
                    bannerURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/level_up_icon.png",
                    description: "Test Description"
                )
            ],
            products: [
                ProductItem(
                    name: "Test Product",
                    imageURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/level_up_icon.png",
                    description: "Test Description"
                )
            ],
            cash: CashItem(
                title: "Test Cash",
                bannerURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/level_up_icon.png",
                description: "Test Description"
            )
        )
        let mockProductService = MockProductService(mockResponse: .success(mockResponse))
        let viewModel = HomeViewModel(productService: mockProductService)
        
        // When
        viewModel.fetchProducts()
        
        // Then
        XCTAssertFalse(viewModel.showError)
        
        XCTAssertEqual(viewModel.spotlightItems.count, 1)
        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertEqual(viewModel.cashItem.title, "Test Cash")
    }
    
    func testFetchProducts_Failure() {
        // Given
        let mockProductService = MockProductService(mockResponse: .failure(MockError.mockFailure))
        let viewModel = HomeViewModel(productService: mockProductService)
        
        // When
        viewModel.fetchProducts()
        
        // Then
        XCTAssertTrue(viewModel.showError)
        
        XCTAssertEqual(viewModel.spotlightItems.count, 0)
        XCTAssertEqual(viewModel.products.count, 0)
        XCTAssertEqual(viewModel.cashItem.title, "")
    }
    
    // MARK: - Mock Classes
    
    class MockProductService: ProductService {
        private let mockResponse: Result<StoreResponse, Error>
        
        init(mockResponse: Result<StoreResponse, Error>) {
            self.mockResponse = mockResponse
        }
        
        override func fetchProducts(completion: @escaping (Result<StoreResponse, Error>) -> Void) {
            completion(mockResponse)
        }
    }
    
    enum MockError: Error {
        case mockFailure
    }
}
