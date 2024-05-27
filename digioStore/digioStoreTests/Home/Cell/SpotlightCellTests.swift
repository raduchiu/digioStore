//
//  SpotlightCellTests.swift
//  digioStoreTests
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import XCTest
@testable import digioStore

class SpotlightCellTests: XCTestCase {
    
    var cell: SpotlightCell!
    
    override func setUp() {
        super.setUp()
        cell = SpotlightCell()
    }
    
    override func tearDown() {
        cell = nil
        super.tearDown()
    }
    
    func testImageViewNotNil() {
        XCTAssertNotNil(cell.bannerImageView, "Banner image view should not be nil")
    }
    
    func testConfigureWithSpotlightItem() {
        // Given
        let spotlightItem = SpotlightItem(
            name: "Digio",
            bannerURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png",
            description: "Teste para banco digio"
        )
        
        
        // When
        let cell = SpotlightCell(frame: .zero)
        let expectation = XCTestExpectation(description: "Image loaded")

        
           cell.configure(with: spotlightItem)

           DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
               expectation.fulfill()
           }
        wait(for: [expectation], timeout: 5.0)

        
        // Then
        XCTAssertNotNil(cell.bannerImageView.image, "Image should be loaded")
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
