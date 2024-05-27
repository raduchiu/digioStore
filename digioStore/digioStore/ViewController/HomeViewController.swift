//
//  HomeViewController.swift
//  digioStore
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import UIKit

class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel

    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.labelFont
        label.textAlignment = .left
        label.text = "Olá, \(viewModel.userName)"
        return label
    }()

    lazy var productsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.labelFont
        label.textAlignment = .left
        label.text = "Produtos"
        return label
    }()

    lazy var cashLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "digio cash"

        let digioAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue,
            .font: Constants.labelFont
        ]
        let cashAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: Constants.labelFont
        ]

        let attributedText = NSMutableAttributedString(string: "digio ", attributes: digioAttributes)
        attributedText.append(NSAttributedString(string: "Cash", attributes: cashAttributes))

        label.attributedText = attributedText

        return label
    }()

    lazy var spotlightCarousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let carousel = UICollectionView(frame: .zero, collectionViewLayout: layout)
        carousel.translatesAutoresizingMaskIntoConstraints = false

        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.carouselItemSpacing
        carousel.backgroundColor = .clear
        carousel.showsHorizontalScrollIndicator = false
        carousel.isPagingEnabled = true
        return carousel
    }()

    lazy var productsCarousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let carousel = UICollectionView(frame: .zero, collectionViewLayout: layout)
        carousel.translatesAutoresizingMaskIntoConstraints = false

        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.productCellSpacing
        carousel.backgroundColor = .clear
        carousel.showsHorizontalScrollIndicator = false
        carousel.isPagingEnabled = true
        return carousel
    }()

    lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    lazy var errorAlert: UIAlertController = {
        let alert = UIAlertController(title: "Erro",
                                      message: "Ocorreu um erro ao carregar os produtos.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    // MARK: - Initializers

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewObservers()
        setupViews()
        viewModel.fetchProducts()
    }

    private func setupCollectionViewObservers() {
        viewModel.updateSpotlightItems = { [weak self] in
            DispatchQueue.main.async {
                self?.spotlightCarousel.reloadData()
            }
        }

        viewModel.updateProducts = { [weak self] in
            DispatchQueue.main.async {
                self?.productsCarousel.reloadData()
            }
        }

        viewModel.updateCashItem = { [weak self] in
            DispatchQueue.main.async {
                self?.setupCashBannerImageView()
            }
        }
    }
    
    // MARK: - UI Setup Methods

    private func setupViews() {
        view.backgroundColor = .white

        configureWelcomeLabel()
        setupSpotlightCarousel()
        setupCashLabel()
        setupCashBannerImageView()
        setupProductsLabel()
        configureProductsCarousel()
        configureLoadingIndicator()

        spotlightCarousel.dataSource = self
        spotlightCarousel.delegate = self
        spotlightCarousel.register(SpotlightCell.self, forCellWithReuseIdentifier: "SpotlightCell")

        productsCarousel.dataSource = self
        productsCarousel.delegate = self
        productsCarousel.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")

        viewModel.updateLoadingStatus = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.loadingIndicator.startAnimating()
                } else {
                    self?.loadingIndicator.stopAnimating()
                }
            }
        }

        viewModel.showErrorAlert = { [weak self] in
            DispatchQueue.main.async {
                self?.displayErrorAlert()
            }
        }
    }

    private func configureWelcomeLabel() {
        view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                              constant: Constants.welcomeLabelTop),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: Constants.welcomeLabelLeading),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: Constants.welcomeLabelTrailing)
        ])
    }

    private func setupSpotlightCarousel() {
        view.addSubview(spotlightCarousel)
        spotlightCarousel.contentInset = UIEdgeInsets(top: Constants.carouselVerticalEdgeInsets,
                                                      left: Constants.carouselHorizontalInset,
                                                      bottom: Constants.carouselVerticalEdgeInsets,
                                                      right: Constants.carouselHorizontalInset)
        NSLayoutConstraint.activate([
            spotlightCarousel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor,
                                                   constant: Constants.topSpacing),
            spotlightCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spotlightCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spotlightCarousel.heightAnchor.constraint(equalToConstant: Constants.carouselHeight)
        ])
    }

    private func setupCashLabel() {
        view.addSubview(cashLabel)

        NSLayoutConstraint.activate([
            cashLabel.topAnchor.constraint(equalTo: spotlightCarousel.bottomAnchor,
                                           constant: Constants.topSpacing),
            cashLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: Constants.cashLabelLeading)
        ])
    }

    private func setupCashBannerImageView() {
        view.addSubview(bannerImageView)

        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: cashLabel.bottomAnchor,
                                                 constant: Constants.topSpacing),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: Constants.bannerImageViewLeading),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: Constants.bannerImageViewTrailing),
            bannerImageView.heightAnchor.constraint(equalToConstant: Constants.bannerImageViewHeight)
        ])

        bannerImageView.layer.cornerRadius = Constants.cellCornerRadius
        bannerImageView.layer.masksToBounds = true

        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(imageTapped(tapGestureRecognizer:))
        )
        bannerImageView.isUserInteractionEnabled = true
        bannerImageView.addGestureRecognizer(tapGestureRecognizer)
        
        UIImage.loadImage(from: viewModel.cashItem.bannerURL) { [weak self] image in
            self?.bannerImageView.image = image
        }
    }

    private func configureLoadingIndicator() {
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupProductsLabel() {
        view.addSubview(productsLabel)
        NSLayoutConstraint.activate([
            productsLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor,
                                               constant: Constants.productsLabelSize),
            productsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: Constants.productsLabelSize),
            productsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productsLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        ])
    }

    private func configureProductsCarousel() {
        view.addSubview(productsCarousel)
        productsCarousel.contentInset = UIEdgeInsets(top: Constants.carouselVerticalEdgeInsets,
                                                     left: Constants.carouselHorizontalInset,
                                                     bottom: Constants.carouselVerticalEdgeInsets,
                                                     right: Constants.carouselHorizontalInset)
        NSLayoutConstraint.activate([
            productsCarousel.topAnchor.constraint(equalTo: productsLabel.bottomAnchor,
                                                  constant: Constants.topSpacing),
            productsCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productsCarousel.heightAnchor.constraint(equalToConstant: Constants.productsCarouselHeight)
        ])
    }

    private func displayErrorAlert() {
        present(errorAlert, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        let item = ProductItem(
            name: viewModel.cashItem.title,
            imageURL: viewModel.cashItem.bannerURL,
            description: viewModel.cashItem.description
        )
        let productDetailViewModel = ProductDetailViewModel(product: item)
        let productDetailVC = ProductDetailViewController(viewModel: productDetailViewModel)
        self.present(productDetailVC, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == spotlightCarousel {
            return viewModel.spotlightItems.count
        } else {
            return viewModel.products.count
        }
    }
    
    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == spotlightCarousel {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "SpotlightCell", for: indexPath) as? SpotlightCell
            if let cell = cell {
                let spotlightItem = viewModel.spotlightItems[indexPath.item]
                cell.configure(with: spotlightItem)
                return cell
            } else {
                return UICollectionViewCell()
            }
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell
            if let cell = cell {
                let productItem = viewModel.products[indexPath.item]
                cell.configure(with: productItem)
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var item: ProductItem
        if collectionView == spotlightCarousel {
            item = viewModel.spotlightToProduct(viewModel.spotlightItems[indexPath.item])
        } else {
            item = viewModel.products[indexPath.item]
        }
        let productDetailViewModel = ProductDetailViewModel(product: item)
        let productDetailVC = ProductDetailViewController(viewModel: productDetailViewModel)
        self.present(productDetailVC, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width

        if collectionView == spotlightCarousel {
            return Constants.spotlightCarouselItemSize(
                collectionViewWidth: collectionViewWidth)
        } else {
            return Constants.productsCarouselItemSize(
                collectionViewWidth: collectionViewWidth)
        }
    }
}
