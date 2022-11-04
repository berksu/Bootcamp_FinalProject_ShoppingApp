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
    }
    
    var changeHandler: ((ProductFetchResults) -> Void)?
    
    private var products:[Product] = []{
        didSet{
            changeHandler?(.didFetchProducts)
        }
    }
    
    private var allProducts:[Product] = []
    
    var productCount: Int{
        products.count
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
            changeHandler?(.didFetchProducts)
            allProducts = data
            products = data
        } catch {
            changeHandler?(.didErrorOccurred("File cannot parsed"))
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
