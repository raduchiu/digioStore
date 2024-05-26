//
//  CashItem.swift
//  digioStore
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import Foundation

struct CashItem: Codable {
    let title: String?
    let bannerURL: String?
    let description: String?
    
    init(title: String? = "",
         bannerURL: String? = "",
         description: String? = "") {
        self.title = title
        self.bannerURL = bannerURL
        self.description = description
    }
}
