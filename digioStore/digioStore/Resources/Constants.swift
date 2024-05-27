//
//  Constants.swift
//  digioStore
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import UIKit

struct Constants {
    // MARK: - Fonts
    static let labelFont: UIFont = .systemFont(ofSize: 20, weight: .bold)
    static let descriptionLabelFont: UIFont = UIFont.systemFont(ofSize: 16)

    // MARK: - Heights
    static let labelHeight: CGFloat = 28
    static let carouselHeight: CGFloat = 200
    static let bannerHeight: CGFloat = 90
    static let productsCarouselHeight: CGFloat = 140
    static let productDetailImageHeight: CGFloat = 200
    static let productDetailNameHeight: CGFloat = 30

    // MARK: - Spacing
    static let carouselItemSpacing: CGFloat = 10
    static let cellCornerRadius: CGFloat = 20
    static let topSpacing: CGFloat = 12
    static let productCellSpacing: CGFloat = 20
    static let carouselHorizontalInset: CGFloat = 24
    static let productsCarouselHorizontalInset: CGFloat = 24

    // MARK: - Shadows
    static let cellShadowOpacity: Float = 0.2
    static let cellShadowOffset = CGSize(width: 0, height: 2)
    static let cellShadowRadius: CGFloat = 4

    // MARK: - Carousel Insets & Spacing
    static let carouselMinimumLineSpacing: CGFloat = 10
    static let carouselVerticalEdgeInsets: CGFloat = 0
    static let welcomeLabelLeading: CGFloat = 24
    static let welcomeLabelTrailing: CGFloat = 20
    static let cashLabelLeading: CGFloat = 24
    static let bannerImageViewLeading: CGFloat = 24
    static let bannerImageViewTrailing: CGFloat = -24

    // MARK: - Positions
    static let welcomeLabelTop: CGFloat = 20
    static let cashLabelTop: CGFloat = 12
    static let bannerImageViewHeight: CGFloat = 90
    static let productsLabelSize: CGFloat = 24
    static let productCellsPerRow: CGFloat = 3

    // MARK: - Dynamic Sizes
    static func spotlightCarouselItemSize(collectionViewWidth: CGFloat) -> CGSize {
        return CGSize(width: collectionViewWidth - 48, height: 170)
    }

    static func productsCarouselItemSize(collectionViewWidth: CGFloat) -> CGSize {
        return CGSize(width: collectionViewWidth/3, height: collectionViewWidth/3)
    }

    // MARK: - Product Detail Positions
    static let productDetailImageTop: CGFloat = 20
    static let productDetailImageLeading: CGFloat = 24
    static let productDetailImageTrailing: CGFloat = -24
    static let productDetailNameTop: CGFloat = 16
    static let productDetailNameLeading: CGFloat = 24
    static let productDetailNameTrailing: CGFloat = -24
    static let productDetailDescriptionTop: CGFloat = 8
    static let productDetailDescriptionLeading: CGFloat = 24
    static let productDescriptionTrailing: CGFloat = -24
    static let imageSize: CGFloat = 48
}
