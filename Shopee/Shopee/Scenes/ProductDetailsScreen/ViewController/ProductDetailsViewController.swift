//
//  ProductDetailsViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 1.11.2022.
//

import UIKit

final class ProductDetailsViewController: UIViewController, AlertPresentable{
    private let productDetailView = ProductDetailView()
    private let productDetailsViewModel = ProductDetailsViewModel()

    private var isProductAlreadyAddedToCart: Bool = false
    private var productThatAlreadyAddedCount: Int?{
        didSet{
            isProductAlreadyAddedToCart = true
        }
    }

    var product: Product?{
        didSet{
            guard let product = product else{return}
            productDetailsViewModel.fetchChosenProductCount(productID: product.id)
            productDetailView.title = product.title
            productDetailView.descriptionText = product.description
            productDetailView.price = product.price
            productDetailView.rate = product.rating?.rate
            productDetailView.commentCount = product.rating?.count
            productDetailsViewModel.getImageFrom(url: product.image ?? "", imageView: productDetailView.productImageView, imageSize: CGFloat.screenWidth * 0.6)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        view = productDetailView
        
        navigationController?.navigationBar.tintColor = .systemGray
        
        productDetailView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        productDetailView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        productDetailView.minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        productDetailView.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        productDetailsViewModel.changeHandler = {[weak self] change in
            switch change{
            case .didProductAddedToCartSuccessfully:
                self?.showAlert(title: "Success", message: "Product added to cart successfully"){[weak self] _ in
                    self?.dismiss(animated: true)
                }
            case .didChosenProductFetchedSuccessfully(let count):
                self?.productDetailView.productCount = count
                self?.productThatAlreadyAddedCount = self?.productDetailView.productCount
            case .didChosenProductRemovedSuccessfully:
                self?.showAlert(title: "Removed", message: "You removed the product form cart successfully."){[weak self] _ in
                    self?.dismiss(animated: true)
                }
            case .didErrorOccurred(let error):
                self?.showError(error)
            }
        }
    }
    
    @objc func backButtonTapped(sender: UIButton){
        dismiss(animated: true)
    }
    
    @objc func plusButtonTapped(sender: UIButton){
        sender.showAnimation {[weak self] in
            // TODO: - If api send maximum number of product and maximum number of product that user can buy, add condition
            guard let productCount = self?.productDetailView.productCount else{return}
            self?.productDetailView.productCount = productCount + 1
            
            if let count = self?.productThatAlreadyAddedCount{
                if self?.productDetailView.productCount != count{
                    self?.productDetailView.isAddToCartButton = .updateCart
                }else{
                    self?.productDetailView.isAddToCartButton = .addToCart
                }
            }else{
                self?.productDetailView.isAddToCartButton = .addToCart
            }
        }
    }
    
    @objc func minusButtonTapped(sender: UIButton){
        sender.showAnimation {[weak self] in
            guard let productCount = self?.productDetailView.productCount else{return}
            if productCount > 0{
                self?.productDetailView.productCount = productCount - 1
            }
            
            if let count = self?.productThatAlreadyAddedCount{
                if self?.productDetailView.productCount == 0{
                    self?.productDetailView.isAddToCartButton = .removeFromCart
                }else if self?.productDetailView.productCount != count{
                    self?.productDetailView.isAddToCartButton = .updateCart
                }
            }else{
                self?.productDetailView.isAddToCartButton = .addToCart
            }
        }
    }
    
    @objc func addToCart(sender: UIButton){
        sender.showAnimation {[weak self] in
            guard let product = self?.product else{return}
            guard let productCount = self?.productDetailView.productCount else{return}
            guard let isAlreadyAdded = self?.isProductAlreadyAddedToCart else{return}
            if !isAlreadyAdded && productCount == 0{
                self?.showAlert(title: "Error", message: "0 product cannot be added to your cart.")
            }else if isAlreadyAdded && productCount == 0{
                self?.showAlert(title: "Message", message: "Do you want to remove item form your cart ?", cancelButtonTitle: "Cancel"){[weak self]_ in
                    self?.productDetailsViewModel.removeChosenProductFromCart(productID: product.id)
                }
            }else{
                self?.productDetailsViewModel.addProductToCart(product: product, count: productCount)
            }
        }
    }
}




#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ProductDetailViewController_Preview: PreviewProvider {

    static var previews: some View {
        ViewControllerPreview {
            ProductDetailsViewController()
        }
    }
}

#endif
