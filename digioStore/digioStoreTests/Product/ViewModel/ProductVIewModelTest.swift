//
//  ProductVIewModelTest.swift
//  digioStoreTests
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import XCTest
@testable import digioStore

class ProductDetailViewModelTests: XCTestCase {

    // Mock ProductItem for testing
    let mockProduct = ProductItem(
        name: "Test Product",
        imageURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png",
        description: "Test Description"
    )

    func testLoadProductImage_WithValidURL_ReturnsImage() {
        // Given
        let viewModel = ProductDetailViewModel(product: mockProduct)
        let productName = viewModel.productName
        let productDescription = viewModel.productDescription
        // When
        let expectation = self.expectation(description: "Image loaded")
        XCTAssertEqual(productName, "Test Product")
        XCTAssertEqual(productDescription, "Test Description")
        viewModel.loadProductImage { image in
            // Then
            XCTAssertNotNil(image)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testLoadProductImage_WithInvalidURL_ReturnsNil() {
        // Given
        let mockProductWithInvalidURL = ProductItem(
            name: nil,
            imageURL: "dwdwdw",
            description: nil
        )
        let viewModel = ProductDetailViewModel(product: mockProductWithInvalidURL)
        let productName = viewModel.productName
        let productDescription = viewModel.productDescription
        // When
        let expectation = self.expectation(description: "Image loaded")
        XCTAssertEqual(productName, "")
        XCTAssertEqual(productDescription, "")
        viewModel.loadProductImage { image in
            // Then
            XCTAssertNil(image)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}

