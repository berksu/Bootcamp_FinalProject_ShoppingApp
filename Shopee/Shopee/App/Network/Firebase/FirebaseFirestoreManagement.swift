//
//  FirebaseFirestoreManagement.swift
//  Shopee
//
//  Created by Berksu Kısmet on 28.10.2022.
//

import Foundation
import Firebase

// MARK: - Firebase firestore
struct FirebaseFirestoreManagement {
    enum FirestoreMessages{
        case didErrorOccurred(_ error: Error)
        case didUserSavedInSuccessful
    }
    
    static var shared = FirebaseFirestoreManagement()
    private let db: Firestore
    private init(){
        db = Firestore.firestore()
    }
    
    func saveUser(user: UserProfile, completion: @escaping (FirestoreMessages) -> Void){
        
        let userDictionary: [String:Any] = ["id": user.id,
                                       "email": user.email,
                                       "username": user.username,
                                       "profilePicture": user.profilePicture]
        
        self.db.collection("users").document(user.id).setData(userDictionary) { error in
            if let error = error {
                completion(.didErrorOccurred(error))
            } else {
                completion(.didUserSavedInSuccessful)
            }
        }
        
    }
}
