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
    static var shared = FirebaseAuthentication()
    
    let auth: Auth
    
    private init(){
        auth =  Auth.auth()
    }
    
    var user: User? {
        auth.currentUser
    }
    
    var userMail: String {
        if let user = user {
            let mail = user.email!
            let mailParts = mail.components(separatedBy: "@")
            return mailParts[0]
        }else{
            return ""
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
        } catch {
            print("error signOut: \(error.localizedDescription)")
        }
    }
    
    // TODO: - Sign In, Sign out and remove password will be added
    // Forget password
    //Auth.auth().sendPasswordReset(withEmail: email) { error in
    //  // [START_EXCLUDE]
    //  strongSelf.hideSpinner {
    //    if let error = error {
    //      strongSelf.showMessagePrompt(error.localizedDescription)
    //      return
    //    }
    //    strongSelf.showMessagePrompt("Sent")
    //  }
    //  // [END_EXCLUDE]
    //}


    // Set user password
    //Auth.auth().currentUser?.updatePassword(to: password) { error in
    //  // ...
    //}


}
