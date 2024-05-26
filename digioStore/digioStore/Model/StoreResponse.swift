//
//  StoreResponse.swift
//  digioStore
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import Foundation

struct StoreResponse: Codable {
    let spotlights: [SpotlightItem]
    let products: [ProductItem]
    let cash: CashItem
}
