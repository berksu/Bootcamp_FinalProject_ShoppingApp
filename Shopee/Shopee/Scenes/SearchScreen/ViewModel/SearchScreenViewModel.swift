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
    }
    
    var changeHandler: ((ProductFetchResults) -> Void)?
    
    var products:[Product] = []{
        didSet{
            changeHandler?(.didFetchProducts)
        }
    }
    
    var allProducts:[Product] = []
    var filteredProducts:[Product] = []

    init(){
        fetchData()
    }
    
    var categories: [String]{
        [
            "electronics",
            "jewelery",
            "men's clothing",
            "women's clothing"
        ]
    }
    
    func fetchData(){
        let url = Bundle.main.url(forResource: "products", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            // the name data is misleading
            let data = try decoder.decode([Product].self, from: jsonData)
            products = data
            allProducts = data
        } catch {
            changeHandler?(.didErrorOccurred("File cannot parsed"))
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
