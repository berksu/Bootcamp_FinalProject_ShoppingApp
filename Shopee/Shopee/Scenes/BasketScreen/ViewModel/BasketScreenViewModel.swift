//
//  BasketScreenViewModel.swift
//  Shopee
//
//  Created by Berksu Kısmet on 3.11.2022.
//

import UIKit

final class BasketScreenViewModel{
    enum BasketScreenViewModelChanges{
        case didProductThatInCartFetchedSuccessfully(_ cartProducts: [CartProduct])
        case didChosenProductRemovedSuccessfully
        case didUpdatedSuccessfully
        case didErrorOccurred(_ error: Error)
    }
    
    var changeHandler: ((BasketScreenViewModelChanges) -> Void)?
    
    func fetchAllProductsThatInBasket(){
        FirebaseFirestoreManagement.shared.fetchAllProductThatInTheCart {[weak self] message in
            switch message{
            case .didErrorOccurred(let error):
                self?.changeHandler?(.didErrorOccurred(error))
            case .didProductsThatInCartFetchedSuccessfully(let cartProducts):
                self?.changeHandler?(.didProductThatInCartFetchedSuccessfully(cartProducts))
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
    
    func removeAllProductsFromCart(productIDs: [Int]){
        for productID in productIDs{
            FirebaseFirestoreManagement.shared.removeChosenProduct(chosenProductID: productID) {[weak self] message in
                switch message{
                case .didErrorOccurred(let error):
                    self?.changeHandler?(.didErrorOccurred(error))
                case .didChosenProductRemovedSuccessfully:
                    print("removed successfully")
                    self?.changeHandler?(.didChosenProductRemovedSuccessfully)
                default:
                    break
                }
            }
        }
    }
    
    func updateProductsInBasket(_ cartProducts: [CartProduct]){
        for cartProduct in cartProducts{
            FirebaseFirestoreManagement.shared.addProductToDatabase(cartProduct: cartProduct) {[weak self] message in
                switch message{
                case .didErrorOccurred(let error):
                    self?.changeHandler?(.didErrorOccurred(error))
                default:
                    break
                }
            }
        }
    }
    
    func downloadProductImage(url: String, imageView: UIImageView){
        KingfisherOperations.shared.downloadBasketImage(url: url, imageView: imageView)
    }
    
    func calculateTotalPrice(productsThatInCart: [CartProduct]) throws -> Double{
        var total = 0.0
        try productsThatInCart.forEach { element in
            guard let productPrice = element.product?.price else{throw ShopeeError.unknown}
            guard let productCount = element.count else{throw ShopeeError.unknown}

            total += productPrice * Double(productCount)
        }
        return total
    }
}

enum ShopeeError: Error {
    case unknown
}
