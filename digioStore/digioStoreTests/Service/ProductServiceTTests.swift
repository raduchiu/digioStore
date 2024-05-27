//
//  ProductServiceTTests.swift
//  digioStoreTests
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import XCTest
@testable import digioStore

class ProductServiceTests: XCTestCase {

    func testFetchProducts_ValidURL_SuccessfulResponse() {
        // Given
        let productService = ProductService()
        let expectation = XCTestExpectation(description: "Fetch products successful")

        // When
        productService.fetchProducts { result in
            // Then
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

}

