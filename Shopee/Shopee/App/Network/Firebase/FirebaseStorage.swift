//
//  FirebaseStorage.swift
//  Shopee
//
//  Created by Berksu Kısmet on 6.11.2022.
//

import Foundation
import FirebaseStorage

// MARK: - Firebase Storage
struct FirebaseStorage {
    enum FirebaseStorageMessages{
        case didErrorOccurred(_ error: Error)
        case didImageUploadedSuccessfully(_ url: String)
    }

    static var shared = FirebaseStorage()
    var storage = Storage.storage().reference()
    private init(){
        storage = Storage.storage().reference()
    }
    
    func uploadProfileImage(imageData: Data, completion: @escaping(FirebaseStorageMessages)->() ){
        guard let userId = FirebaseAuthentication.shared.userID else{return}
        let ref = storage.child("profileImages/\(userId).png")
        ref.putData(imageData,
                    metadata: nil,
                    completion: {_, error in
            if let error = error as? NSError{
                completion(.didErrorOccurred(error))
                return
            }else{
                ref.downloadURL(completion: {url, error in
                    guard let url = url, error == nil else{
                        guard let error = error as? NSError else{return}
                        completion(.didErrorOccurred(error))
                        return
                    }
                    
                    let urlString = url.absoluteString
                    completion(.didImageUploadedSuccessfully(urlString))
                })
            }
        })
    }
}


