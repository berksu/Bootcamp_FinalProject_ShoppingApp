//
//  KingfisherOperations.swift
//  Shopee
//
//  Created by Berksu Kısmet on 30.10.2022.
//

import UIKit
import Kingfisher

struct KingfisherOperations{
    enum KingisherResults{
        case didErrorOccurred(_ error: Error)
        case imageDownloadedSuccessfully
    }
    
    static var shared = KingfisherOperations()
    
    private init(){}
    
    // Download normal image from url
    func downloadImage(url: String, imageView: UIImageView, completion: @escaping (KingisherResults) -> Void){
        let url = URL(string: url)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named:"productPlaceholder")?.withColor(.systemGray),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(_):
                completion(.imageDownloadedSuccessfully)
            case .failure(let error):
                completion(.didErrorOccurred(error))
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}


