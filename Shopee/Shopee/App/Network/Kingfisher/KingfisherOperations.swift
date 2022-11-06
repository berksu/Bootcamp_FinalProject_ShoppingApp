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
    
    func downloadProfileImage(url: String, imageView: UIImageView, size: CGFloat){
        let url = URL(string: url)
        let processor = ResizingImageProcessor(referenceSize: CGSize(width: size, height: size))
                     |> RoundCornerImageProcessor(cornerRadius: size/2)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "profileImagePlaceholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    func downloadBasketImage(url: String, imageView: UIImageView){
        let url = URL(string: url)
        let processor = DownsamplingImageProcessor(size: CGSize(width: 100, height: 100))
                     |> RoundCornerImageProcessor(cornerRadius: 10)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "profileImagePlaceholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}


