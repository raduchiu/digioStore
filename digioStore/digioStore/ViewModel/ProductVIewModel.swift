//
//  ProductVIewModel.swift
//  digioStore
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import Foundation
import UIKit

class ProductDetailViewModel {
    private let product: ProductItem

    var productName: String {
        return product.name ?? ""
    }

    var productDescription: String {
        return product.description ?? ""
    }

    init(product: ProductItem) {
        self.product = product
    }

    func loadProductImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = product.imageURL else {
            completion(nil)
            return
        }

        UIImage.loadImage(from: imageURL) { image in
            completion(image)
        }
    }
}
