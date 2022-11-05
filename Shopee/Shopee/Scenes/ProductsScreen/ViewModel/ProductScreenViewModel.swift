//
//  ProductScreenViewModel.swift
//  Shopee
//
//  Created by Berksu Kısmet on 30.10.2022.
//

import Foundation

final class ProductScreenViewModel{
    
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
    
    private var products:[Product] = []{
        didSet{
            changeHandler?(.didFetchProducts)
        }
    }
    
    private var allProducts:[Product] = []
    
    var productCount: Int{
        products.count
    }
    
    var categories: [String] = []
    
    init(){
        fetchCategories()
    }
    
//    func fetchData(){
//        let url = Bundle.main.url(forResource: "products", withExtension: "json")!
//        do {
//            let jsonData = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            // the name data is misleading
//            let data = try decoder.decode([Product].self, from: jsonData)
//            changeHandler?(.didFetchProducts)
//            allProducts = data
//            products = data
//        } catch {
//            changeHandler?(.didErrorOccurred("File cannot parsed"))
//        }
//    }
    
    func fetchData(){
        FakeStoreApiManagement.shared.fetchData {[weak self] message in
            switch message{
            case .didErrorOccurred(let error):
                self?.changeHandler?(.didErrorOccurred(error))
            case .didFetchProducts(let productList):
                self?.changeHandler?(.didFetchProducts)
                self?.allProducts = productList
                self?.products = productList
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
    
    func getImageURLAtIndex(_ index: Int) -> String{
        if let image = products[index].image{
            return image
        }else{
            return ""
        }
    }
    
    func getProductAtIndex(_ index: Int) -> Product{
        return products[index]
    }
    
    func searchProuct(category: String){
        products = allProducts.filter { product in
            guard let categories = product.category else{return false}
            return categories == category
        }.map{$0}
    }
}
