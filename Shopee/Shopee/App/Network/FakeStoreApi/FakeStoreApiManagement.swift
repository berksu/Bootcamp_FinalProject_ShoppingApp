//
//  FakeStoreApiManagement.swift
//  Shopee
//
//  Created by Berksu Kısmet on 6.11.2022.
//

import Foundation

struct FakeStoreApiManagement{
    enum ProductFetchResults {
        case didErrorOccurred(_ error: String)
        case didFetchProducts(_ products: [Product])
        case didFetchCategories(_ categories: [String])
    }
    
    static var shared = FakeStoreApiManagement()
    
    private init(){}
    
    func fetchData(completion: @escaping((ProductFetchResults)-> Void)){
        provider.request(.getAllProducts) {result in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                do{
                    let productList = try JSONDecoder().decode([Product].self, from: response.data)
                    completion(.didFetchProducts(productList))
                }catch{
                    completion(.didErrorOccurred("File cannot be parsed"))
                }
            }
        }
    }
    
    func fetchCategories(completion: @escaping((ProductFetchResults)-> Void)){
        provider.request(.getAllCategories){result in
            switch result{
            case .failure(let error):
                completion(.didErrorOccurred("\(error.localizedDescription)"))
            case .success(let response):
                do{
                    let categoryList = try JSONDecoder().decode([String].self, from: response.data)
                    completion(.didFetchCategories(categoryList))
                }catch{
                    completion(.didErrorOccurred("File cannot be parsed"))
                }
            }
        }
    }
}
