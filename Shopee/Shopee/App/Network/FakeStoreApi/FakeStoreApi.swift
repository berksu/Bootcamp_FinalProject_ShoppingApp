//
//  FakeStoreApi.swift
//  Shopee
//
//  Created by Berksu Kısmet on 29.10.2022.
//

import Foundation
import Moya

let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .default))
//let provider = MoyaProvider<FakeStoreApi>(plugins: [plugin])
let provider = MoyaProvider<FakeStoreApi>(plugins: [plugin])

// TODO: - Search content should be filtered.
enum FakeStoreApi {
    case getAllProducts
    case getAllCategories
}

// MARK: - TargetType
extension FakeStoreApi: TargetType{
    
    var baseURL: URL {
        guard let url = URL(string: "https://fakestoreapi.com") else {
            fatalError("Base URL not found or not in correct format")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getAllProducts:
            return "/products"
        case .getAllCategories:
            return "/products/categories"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        let parameters:[String : Any] = [:]
        return .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
}

