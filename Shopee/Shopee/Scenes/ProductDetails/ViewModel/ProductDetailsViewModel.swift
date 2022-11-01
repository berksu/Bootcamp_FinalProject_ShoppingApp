//
//  ProductDetailsViewModel.swift
//  Shopee
//
//  Created by Berksu Kısmet on 2.11.2022.
//

import UIKit

final class ProductDetailsViewModel{
    func getImageFrom(url: String, imageView: UIImageView, imageSize: CGFloat){
        KingfisherOperations.shared.downloadImage(url: url, imageView: imageView) { result in
            switch result{
            case .didErrorOccurred(let error):
                print("Error: \(error)")
            case .imageDownloadedSuccessfully:
                print("Successful")
            }
        }
    }
}
