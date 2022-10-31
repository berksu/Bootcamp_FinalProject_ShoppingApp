//
//  FirebaseFirestoreManagement.swift
//  Shopee
//
//  Created by Berksu Kısmet on 28.10.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

// MARK: - Firebase firestore
struct FirebaseFirestoreManagement {
    enum FirestoreMessages{
        case didErrorOccurred(_ error: Error)
        case didUserSavedInSuccessfully
        case didUserFetchedSuccessfully(_ user: UserProfile)
    }
    
    static var shared = FirebaseFirestoreManagement()
    private let db: Firestore
    private init(){
        db = Firestore.firestore()
    }
    
//    func saveUser(user: UserProfile, completion: @escaping (FirestoreMessages) -> Void){
//
//        let userDictionary: [String:Any] = ["id": user.id,
//                                       "email": user.email,
//                                       "username": user.username,
//                                       "profilePicture": user.profilePicture]
//
//        self.db.collection("users").document(user.id).setData(userDictionary) { error in
//            if let error = error {
//                completion(.didErrorOccurred(error))
//            } else {
//                completion(.didUserSavedInSuccessful)
//            }
//        }
//    }
    
    func saveUser(user: UserProfile, completion: @escaping (FirestoreMessages) -> Void){
        do {
            try db.collection("users").document(user.id).setData(from: user)
            completion(.didUserSavedInSuccessfully)
        } catch let error {
            completion(.didErrorOccurred(error))
        }
    }
    
    
    func fetchCurrentUserInfo(completion: @escaping (FirestoreMessages) -> Void){
        guard let id = FirebaseAuthentication.shared.userID else{return}
        let docRef = db.collection("users").document(id)

        docRef.getDocument(as: UserProfile.self) { result in
            switch result {
            case .success(let user):
                completion(.didUserFetchedSuccessfully(user))
            case .failure(let error):
                completion(.didErrorOccurred(error))
            }
        }
    }
}
