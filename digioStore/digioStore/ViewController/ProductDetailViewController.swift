//
//  ProductDetailViewController.swift
//  digioStore
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    private let viewModel: ProductDetailViewModel

    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.labelFont
        label.textAlignment = .left
        return label
    }()

    lazy var productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.descriptionLabelFont
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        displayProductDetails()
    }

    private func configureViews() {
        view.backgroundColor = .white

        view.addSubview(productImageView)
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                  constant: Constants.productDetailImageTop),
            productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                      constant: Constants.productDetailImageLeading),
            productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                       constant: Constants.productDetailImageTrailing),
            productImageView.heightAnchor.constraint(equalToConstant: Constants.productDetailImageHeight)
        ])

        view.addSubview(productNameLabel)
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor,
                                                  constant: Constants.productDetailNameTop),
            productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                      constant: Constants.productDetailNameLeading),
            productNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                       constant: Constants.productDetailNameTrailing),
            productNameLabel.heightAnchor.constraint(equalToConstant: Constants.productDetailNameHeight)
        ])

        view.addSubview(productDescriptionLabel)
        NSLayoutConstraint.activate([
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor,
                                                         constant: Constants.productDetailDescriptionTop),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                             constant: Constants.productDetailDescriptionLeading),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                              constant: Constants.productDescriptionTrailing)
        ])
    }

    private func displayProductDetails() {
        productNameLabel.text = viewModel.productName
        productDescriptionLabel.text = viewModel.productDescription

        viewModel.loadProductImage { [weak self] image in
            self?.productImageView.image = image
        }
    }
}
