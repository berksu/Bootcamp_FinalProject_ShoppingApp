//
//  SearchScreenViewModel.swift
//  Shopee
//
//  Created by Berksu Kısmet on 4.11.2022.
//

import UIKit

final class SearchScreenViewModel{
    
    enum ProductFetchResults {
        case didErrorOccurred(_ error: String)
        case didFetchProducts
        case didFetchCategories
    }
    
    enum BasketFetchResults {
        case didErrorOccurred(_ error: Error)
        case didBasketEmpty(_ isEmpty: Bool)
    }
    
    var changeHandler: ((ProductFetchResults) -> Void)?
    var basketChangeHandler: ((BasketFetchResults) -> Void)?

    var products:[Product] = []{
        didSet{
            changeHandler?(.didFetchProducts)
        }
    }
    
    var allProducts:[Product] = []
    var filteredProducts:[Product] = []

    init(){
        fetchData()
        fetchCategories()
    }
    
    var categories: [String] = []
    
    func fetchData(){
        FakeStoreApiManagement.shared.fetchData {[weak self] message in
            switch message{
            case .didErrorOccurred(let error):
                self?.changeHandler?(.didErrorOccurred(error))
            case .didFetchProducts(let productList):
                self?.changeHandler?(.didFetchProducts)
                self?.allProducts = productList
                self?.products = productList
                self?.filteredProducts = productList
            default:
                break
            }
        }
    }
    
    func fetchCategories(){
        FakeStoreApiManagement.shared.fetchCategories {[weak self] message in
            switch message{
            case .didErrorOccurred(let error):
                self?.changeHandler?(.didErrorOccurred(error))
            case .didFetchCategories(let categoryList):
                self?.categories = categoryList
                self?.changeHandler?(.didFetchCategories)
            default:
                break
            }
        }
    }
    
    func fetchBasket(){
        FirebaseFirestoreManagement.shared.controlBasketIsEmpty {[weak self] message in
            switch message{
            case .didErrorOccurred(let error):
                self?.basketChangeHandler?(.didErrorOccurred(error))
            case .basketMessage(let isEmpty):
                self?.basketChangeHandler?(.didBasketEmpty(isEmpty))
            }
        }
    }
    
    func searchProuct(word: String){
        products = filteredProducts.filter { product in
            guard let titleLowercased = product.title?.lowercased() else{return false}
            return titleLowercased.contains(word.lowercased())
        }.map{$0}
    }
    
    func searchCategory(category: String){
        filteredProducts = allProducts.filter { product in
            guard let categories = product.category else{return false}
            return categories == category
        }.map{$0}
        products = filteredProducts
    }
    
    func showOnlyCategoryResultIfThereIsOne(){
        products = filteredProducts
    }
    
    func removeCategoryFilter(){
        filteredProducts = allProducts
    }
    
    func downloadProductImage(url: String, imageView: UIImageView){
        KingfisherOperations.shared.downloadBasketImage(url: url, imageView: imageView)
    }
}
