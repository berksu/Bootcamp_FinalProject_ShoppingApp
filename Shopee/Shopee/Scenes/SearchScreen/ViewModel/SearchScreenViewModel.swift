//
//  SearchScreenViewModel.swift
//  Shopee
//
//  Created by Berksu Kısmet on 4.11.2022.
//

import UIKit

final class SearchScreenViewModel{
    var products:[Product] = []
    
    init(){
        fetchData()
    }
    
    
    func fetchData(){
        let url = Bundle.main.url(forResource: "products", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            // the name data is misleading
            let data = try decoder.decode([Product].self, from: jsonData)
            products = data
        } catch {
            products = []
        }
    }
    
    
    func searchProuct(word: String) -> [Product]{
        return products.filter { product in
            guard let titleLowercased = product.title?.lowercased() else{return false}
            return titleLowercased.contains(word.lowercased())
        }.map{$0}
    }
    
    func downloadProductImage(url: String, imageView: UIImageView){
        KingfisherOperations.shared.downloadBasketImage(url: url, imageView: imageView)
    }
}
