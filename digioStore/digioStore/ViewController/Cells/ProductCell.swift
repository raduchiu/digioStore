//
//  ProductCell.swift
//  digioStore
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import UIKit

class ProductCell: UICollectionViewCell {
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        applyCellStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        backgroundColor = .white
        contentView.addSubview(productImageView)
        productImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

        let imageSize = contentView.bounds.width - Constants.imageSize
        productImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
    }

    func configure(with product: ProductItem) {
        UIImage.loadImage(from: product.imageURL) { [weak self] image in
            self?.productImageView.image = image
        }
    }

    func applyCellStyle() {
        layer.cornerRadius = Constants.cellCornerRadius
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = Constants.cellShadowOpacity
        layer.shadowOffset = Constants.cellShadowOffset
        layer.shadowRadius = Constants.cellShadowRadius
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
