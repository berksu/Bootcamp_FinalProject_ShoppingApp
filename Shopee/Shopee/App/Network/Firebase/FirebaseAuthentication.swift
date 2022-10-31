//
//  FirebaseAuthentication.swift
//  Shopee
//
//  Created by Berksu Kısmet on 26.10.2022.
//

import Foundation
import FirebaseAuth


// MARK: - Firebase authentication
struct FirebaseAuthentication {
    enum AuthenticationMessages{
        case didErrorOccurred(_ error: Error)
        case didSignInSuccessful
        case didSignUpSuccessful
        case didSignOutSccessful
        case didForgetMessageSentSuccessful
    }
    
    static var shared = FirebaseAuthentication()
    
    let auth: Auth
    
    private init(){
        auth =  Auth.auth()
    }
    
    // get current user
    var user: User? {
        auth.currentUser
    }
    
    // get current user
    var userID: String? {
        auth.currentUser?.uid
    }
    
    var userInfo: UserProfile?
    
    
    // Firebase Sign In
    func signIn(email: String, password: String, complition: @escaping (AuthenticationMessages) -> Void){
        auth.signIn(withEmail: email,
                    password: password){result, error in
            
            if let error = error as? NSError{
                print("Error: \(error.localizedDescription)")
                complition(.didErrorOccurred(error))
                return
            }else{
                print("Sign In")
                complition(.didSignInSuccessful)
            }
            
            guard result != nil, error == nil else{ return }
        }
    }
    
    // Firebase Sign Up
    func signUp(email: String, password: String, username: String, complition: @escaping (AuthenticationMessages) -> Void){
        auth.createUser(withEmail: email,
                        password: password){result, error in
            
            if let error = error as? NSError{
                print("Error: \(error.localizedDescription)")
                complition(.didErrorOccurred(error))
                return
            }
                        
            guard let authResult = result, error == nil else{ return }
            let user = UserProfile(id: authResult.user.uid, username: username, email: email)
          
            // Save user with one's username and profilePicture
            FirebaseFirestoreManagement.shared.saveUser(user: user) { result in
                switch result{
                case .didUserSavedInSuccessfully:
                    complition(.didSignUpSuccessful)
                case .didErrorOccurred(let error):
                    complition(.didErrorOccurred(error))
                default:
                    break
                }
            }
        }
    }
    
    // Firebase sign out
    func signOut(complition: @escaping (AuthenticationMessages) -> Void){
        do {
            try Auth.auth().signOut()
            complition(.didSignOutSccessful)
        } catch {
            print("error signOut: \(error.localizedDescription)")
            complition(.didErrorOccurred(error))
        }
    }
    
    func forgotPassword(email: String, complition: @escaping (AuthenticationMessages) -> Void){
        auth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                complition(.didErrorOccurred(error))
                return
            }
            complition(.didForgetMessageSentSuccessful)
        }
//        user.updatePassword(to: password) { error in
//          // ...
//        }
    }
    


}
