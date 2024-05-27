//
//  ProductDetailViewControllerTests.swift
//  digioStoreTests
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import XCTest
@testable import digioStore

class ProductDetailViewControllerTests: XCTestCase {

    // Mock ProductItem for testing
    let mockProduct = ProductItem(
        name: "Test Product",
        imageURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png",
        description: "Test Description"
    )

    func testViewDidLoad_ConfiguresViews() {
        // Given
        let viewModel = ProductDetailViewModel(product: mockProduct)
        let viewController = ProductDetailViewController(viewModel: viewModel)

        // When
        _ = viewController.view

        // Then
        XCTAssertNotNil(viewController.productImageView)
        XCTAssertNotNil(viewController.productNameLabel)
        XCTAssertNotNil(viewController.productDescriptionLabel)
        XCTAssertEqual(viewController.productImageView.contentMode, .scaleAspectFit)
        XCTAssertEqual(viewController.productNameLabel.textAlignment, .left)
        XCTAssertEqual(viewController.productDescriptionLabel.textAlignment, .left)
        XCTAssertEqual(viewController.productDescriptionLabel.numberOfLines, 0)
    }

    func testDisplayProductDetails_SetsLabelTexts() {
        // Given
        let viewModel = ProductDetailViewModel(product: mockProduct)
        let viewController = ProductDetailViewController(viewModel: viewModel)

        // When
        _ = viewController.view

        // Then
        XCTAssertEqual(viewController.productNameLabel.text, mockProduct.name)
        XCTAssertEqual(viewController.productDescriptionLabel.text, mockProduct.description)
    }
}

