//
//  ProductDetailsViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 1.11.2022.
//

import UIKit

final class ProductDetailsViewController: UIViewController{
    let productDetailView = ProductDetailView()
    let productDetailsViewModel = ProductDetailsViewModel()

    var product: Product?{
        didSet{
            guard let product = product else{return}
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
        
    }
    
    @objc func backButtonTapped(sender: UIButton){
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true)
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
