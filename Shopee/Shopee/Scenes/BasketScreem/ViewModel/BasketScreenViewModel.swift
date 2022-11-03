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
    
    func updateProductsInBasket(_ cartProducts: [CartProduct]){
        for cartProduct in cartProducts{
            FirebaseFirestoreManagement.shared.addProductToDatabase(cartProduct: cartProduct) {[weak self] message in
                switch message{
                case .didErrorOccurred(let error):
                    self?.changeHandler?(.didErrorOccurred(error))
                case .didProductSavedInSuccessfully:
                    print("Successfully updated")
                default:
                    break
                }
            }
        }
    }
    
    func downloadProductImage(url: String, imageView: UIImageView){
        KingfisherOperations.shared.downloadBasketImage(url: url, imageView: imageView)
    }
}
