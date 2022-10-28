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
        //return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
//        switch self{
//        case .getRecentImages(let page):
//            let parameters:[String : Any] = ["method": "flickr.photos.getRecent",
//                              "api_key": "b4e2d5855cd63ed362d1e1dd3d981dc7",
//                              "page": page,
//                              "format": "json",
//                              "nojsoncallback": "1",
//                              "extras" : "date_taken,owner_name,url_n"
//                              ]
//
//            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
//        case .search(let text, let page):
//            let parameters:[String : Any] = ["method": "flickr.photos.search",
//                              "api_key": "b4e2d5855cd63ed362d1e1dd3d981dc7",
//                              "page": page,
//                              "text": text,
//                              "format": "json",
//                              "nojsoncallback": "1",
//                              "extras" : "date_taken,owner_name,url_n"
//                              ]
//
//            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
//        }
    }
    
    var headers: [String : String]? {
        nil
    }
}

