//
//  FirebaseFirestoreManagement.swift
//  Shopee
//
//  Created by Berksu Kısmet on 28.10.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

// MARK: - Firebase firestore
struct FirebaseFirestoreManagement {
    enum FirestoreMessages{
        case didErrorOccurred(_ error: Error)
        case didUserSavedInSuccessfully
        case didUserFetchedSuccessfully(_ user: UserProfile)
        case didProductsThatInCartFetchedSuccessfully(_ productsInCart: [CartProduct])
        case didProductSavedInSuccessfully
        case didChosenProductFetchedInSuccessfully(_ count: Int)
        case didChosenProductRemovedSuccessfully
    }
    
    enum BasketMessages{
        case didErrorOccurred(_ error: Error)
        case basketMessage(_ isEmpty: Bool)
    }
    
    static var shared = FirebaseFirestoreManagement()
    private let db: Firestore
    private init(){
        db = Firestore.firestore()
    }
    
    func saveUser(user: UserProfile, completion: @escaping (FirestoreMessages) -> Void){
        do {
            try db.collection("users").document(user.id).setData(from: user)
            completion(.didUserSavedInSuccessfully)
        } catch let error {
            completion(.didErrorOccurred(error))
        }
    }
    
    func fetchCurrentUserInfo(completion: @escaping (FirestoreMessages) -> Void){
        guard let id = FirebaseAuthentication.shared.userID else{return}
        let docRef = db.collection("users").document(id)

        docRef.getDocument(as: UserProfile.self) { result in
            switch result {
            case .success(let user):
                completion(.didUserFetchedSuccessfully(user))
            case .failure(let error):
                completion(.didErrorOccurred(error))
            }
        }
    }
    
    func addProductToDatabase(cartProduct: CartProduct, completion: @escaping (FirestoreMessages) -> Void){
        guard let userId = FirebaseAuthentication.shared.userID else{return}
        guard let product = cartProduct.product else{return}

        do {
            try db.collection(userId).document("\(product.id)").setData(from: cartProduct)
            completion(.didProductSavedInSuccessfully)
        } catch let error {
            completion(.didErrorOccurred(error))
        }
    }
    
    func fetchChosenProduct(chosenProductID: Int, completion: @escaping (FirestoreMessages) -> Void){
        guard let userId = FirebaseAuthentication.shared.userID else{return}
        let docRef = db.collection(userId).document("\(chosenProductID)")

        docRef.getDocument(as: CartProduct.self) { result in
            switch result {
            case .success(let cartProduct):
                guard let productCount = cartProduct.count else {break}
                completion(.didChosenProductFetchedInSuccessfully(productCount))
            case .failure( _):
                break
            }
        }
    }
    
    func removeChosenProduct(chosenProductID: Int, completion: @escaping (FirestoreMessages) -> Void){
        guard let userId = FirebaseAuthentication.shared.userID else{return}
        
        db.collection(userId).document("\(chosenProductID)").delete() { err in
            if let err = err {
                completion(.didErrorOccurred(err))
            } else {
                completion(.didChosenProductRemovedSuccessfully)
            }
        }
    }
    
    func fetchAllProductThatInTheCart(completion: @escaping (FirestoreMessages) -> Void){
        guard let userId = FirebaseAuthentication.shared.userID else{return}

        db.collection(userId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(.didErrorOccurred(err))
            } else {
                var productThatInCart:[CartProduct] = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    guard let productDictionary = data["product"] as? Dictionary<String, Any> else {continue}
                    guard let ratingDictionary = productDictionary["rating"] as? Dictionary<String, Any> else {continue}
                    guard let productID = productDictionary["id"] as? Int else{continue}
                    
                    let rating = Rating(rate: ratingDictionary["rate"] as? Double,
                                        count: ratingDictionary["count"] as? Int)
                    let product = Product(id: productID,
                                           title: productDictionary["title"] as? String,
                                           price: productDictionary["price"] as? Double,
                                           description: productDictionary["description"] as? String,
                                           category: productDictionary["category"] as? String,
                                           image: productDictionary["image"] as? String,
                                           rating: rating)
                    let cartProduct = CartProduct(product: product,
                                                count: data["count"] as? Int)
                    productThatInCart.append(cartProduct)
                }
                completion(.didProductsThatInCartFetchedSuccessfully(productThatInCart))
            }
        }
    }
    
    func controlBasketIsEmpty(completion: @escaping (BasketMessages) -> Void){
        guard let userId = FirebaseAuthentication.shared.userID else{return}

        db.collection(userId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(.didErrorOccurred(err))
            } else {
                if(querySnapshot!.documents.count == 0){
                    completion(.basketMessage(true))
                }else{
                    completion(.basketMessage(false))
                }
            }
        }
    }
}
