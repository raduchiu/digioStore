//
//  ProductCell.swift
//  digioStoreTests
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import XCTest
@testable import digioStore 
class ProductCellTests: XCTestCase {
    
    var cell: ProductCell!
    
    override func setUp() {
        super.setUp()
        cell = ProductCell()
    }
    
    override func tearDown() {
        cell = nil
        super.tearDown()
    }
    
    func testImageViewNotNil() {
        XCTAssertNotNil(cell.productImageView, "Product image view should not be nil")
    }
    
    func testConfigureWithProductItem() {
        // Given
        let productItem = ProductItem(
            name: "Test Product",
            imageURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png",
            description: "Description"
        )
        
        // When
        let cell = ProductCell(frame: .zero)
        let expectation = XCTestExpectation(description: "Image loaded")
        
        cell.configure(with: productItem)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        // Then
        XCTAssertNotNil(cell.productImageView.image, "Image should be loaded")
    }
    
    func testCellLayerCornerRadius() {
        // Given
        let expectedCornerRadius = Constants.cellCornerRadius
        
        // When
        let actualCornerRadius = cell.layer.cornerRadius
        
        // Then
        XCTAssertEqual(actualCornerRadius, expectedCornerRadius, "Cell layer corner radius should match Constants")
    }
}

