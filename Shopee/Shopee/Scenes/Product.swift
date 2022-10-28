//
//  Product.swift
//  Shopee
//
//  Created by Berksu Kısmet on 29.10.2022.
//

import Foundation

struct Product: Codable{
    let id: Int
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    let rating: Rating?
}

extension Product{
    var imageURL: URL?{
        guard let image = image else{return nil}
        return URL(string: image)
    }
}

struct Rating: Codable{
    let rate: Double
    let count: Int
}


//provider.request(.getAllProducts) { result in
//    switch result{
//    case .failure(let error):
//        print(error.localizedDescription)
//    case .success(let response):
//        do{
//            let productList = try JSONDecoder().decode([Product].self, from: response.data)
//            print(productList)
//        }catch{
//            print(error)
//        }
//    }
//}



//provider.request(.getAllCategories) { result in
//    switch result{
//    case .failure(let error):
//        print(error.localizedDescription)
//    case .success(let response):
//        do{
//            let productList = try JSONDecoder().decode([String].self, from: response.data)
//            print(productList)
//        }catch{
//            print(error)
//        }
//    }
//}
