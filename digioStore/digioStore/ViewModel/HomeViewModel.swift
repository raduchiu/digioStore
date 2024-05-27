//
//  HomeViewModel.swift
//  digioStore
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import Foundation

class HomeViewModel {
    var productService: ProductService
    private(set) var spotlightItems: [SpotlightItem] = []
    private(set) var products: [ProductItem] = []
    private(set) var cashItem: CashItem = CashItem()
    private(set) var userName: String = "Thalia"

    var updateSpotlightItems: (() -> Void)?
    var updateProducts: (() -> Void)?
    var updateCashItem: (() -> Void)?

    var isLoading: Bool = false {
        didSet {
            updateLoadingStatus?(isLoading)
        }
    }

    var showError: Bool = false {
        didSet {
            showErrorAlert?()
        }
    }

    var updateLoadingStatus: ((Bool) -> Void)?
    var showErrorAlert: (() -> Void)?

    init(productService: ProductService) {
        self.productService = productService
    }

    func spotlightToProduct(_ spotlight: SpotlightItem) -> ProductItem {
        return ProductItem(name: spotlight.name,
                       imageURL: spotlight.bannerURL,
                       description: spotlight.description)
    }

    func fetchProducts() {
        isLoading = true

        productService.fetchProducts { [weak self] result in
            guard let self = self else { return }

            self.isLoading = false

            switch result {
            case .success(let response):
                self.spotlightItems = response.spotlight
                self.products = response.products
                self.cashItem = response.cash
                self.updateCashItem?()
                self.updateSpotlightItems?()
                self.updateProducts?()
            case .failure:
                self.showError = true
            }
        }
    }
}
