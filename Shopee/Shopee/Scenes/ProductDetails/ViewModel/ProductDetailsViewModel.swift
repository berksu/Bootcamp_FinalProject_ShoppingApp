//
//  ProductDetailsViewModel.swift
//  Shopee
//
//  Created by Berksu Kısmet on 2.11.2022.
//

import UIKit

final class ProductDetailsViewModel{
    enum ProductDetailsViewModelChanges{
        case didProductAddedToCartSuccessfully
        case didChosenProductFetchedSuccessfully(_ count: Int)
        case didChosenProductRemovedSuccessfully
        case didErrorOccurred(_ error: Error)
    }

    var changeHandler: ((ProductDetailsViewModelChanges) -> Void)?
    
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
    
    func addProductToCart(product: Product, count: Int){
        let cartProduct = CartProduct(product: product, count: count)
        FirebaseFirestoreManagement.shared.addProductToDatabase(cartProduct: cartProduct) {[weak self] message in
            switch message{
            case .didErrorOccurred(let error):
                self?.changeHandler?(.didErrorOccurred(error))
            case .didProductSavedInSuccessfully:
                self?.changeHandler?(.didProductAddedToCartSuccessfully)
            default:
                break
            }
        }
    }
    
    func fetchChosenProductCount(productID: Int){
        FirebaseFirestoreManagement.shared.fetchChosenProduct(chosenProductID: productID) {[weak self] message in
            switch message{
            case .didErrorOccurred(let error):
                self?.changeHandler?(.didErrorOccurred(error))
            case .didChosenProductFetchedInSuccessfully(let count):
                self?.changeHandler?(.didChosenProductFetchedSuccessfully(count))
            default:
                break
            }
        }
    }
    
    func removeChosenProductFromCart(productID: Int){
        FirebaseFirestoreManagement.shared.removeChosenProduct(chosenProductID: productID) {[weak self] message in
            switch message{
            case .didErrorOccurred(let error):
                self?.changeHandler?(.didErrorOccurred(error))
            case .didChosenProductRemovedSuccessfully:
                self?.changeHandler?(.didChosenProductRemovedSuccessfully)
            default:
                break
            }
        }
    }
}
