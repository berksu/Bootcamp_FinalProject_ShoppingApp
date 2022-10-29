//
//  AuthenticationViewModel.swift
//  Shopee
//
//  Created by Berksu Kısmet on 28.10.2022.
//

import Foundation

final class AuthenticationViewModel{
    
    enum AuthenticationViewModelMessages{
        case didErrorOccurred(_ error: Error)
        case didSignInSuccessful
        case didSignUpSuccessful
        case didErrorOccurredAboutUserInputs(_ errorTitle: String, _ errorMessage: String)
    }
    
    var isSignedIn: Bool{
        FirebaseAuthentication.shared.user != nil
    }
    
    var changeHandler: ((AuthenticationViewModelMessages) -> Void)?
    
    func signIn(email: String?, password: String?){
        guard let email = email, email.isValidEmail else {
            changeHandler?(.didErrorOccurredAboutUserInputs("Email Error", "Email is not valid"))
            return
        }
        guard let password = password else {
            changeHandler?(.didErrorOccurredAboutUserInputs("Password Error", "Password is not valid"))
            return
        }
        
        FirebaseAuthentication.shared.signIn(email: email, password: password) {[weak self] message in
            switch message{
            case .didSignInSuccessful:
                self?.changeHandler?(.didSignInSuccessful)
            case .didErrorOccurred(let error):
                self?.changeHandler?(.didErrorOccurred(error))
            default:
                break
            }
        }
    }
    
    func signUp(email: String?, password: String?, reTypedPassword:String?, username: String?){
        guard let username = username else {
            changeHandler?(.didErrorOccurredAboutUserInputs("Username Error", "Username is not valid"))
            return
        }
        
        guard let email = email, email.isValidEmail else {
            changeHandler?(.didErrorOccurredAboutUserInputs("Email Error", "Email is not valid"))
            return
        }
        guard let password = password else {
            changeHandler?(.didErrorOccurredAboutUserInputs("Password Error", "Password is not valid"))
            return
        }
        
        guard let reTypedPassword = reTypedPassword else {
            changeHandler?(.didErrorOccurredAboutUserInputs("Password Error", "Re-Typed Password is not valid"))
            return
        }
        
        if(!password.isValidPassword){
            let errorMessage = password.getMissingValidation().first ?? ""
            changeHandler?(.didErrorOccurredAboutUserInputs("Password Error", errorMessage))
            return
        }
        
        if(password != reTypedPassword){
            changeHandler?(.didErrorOccurredAboutUserInputs("Password Error", "Password and ReTyped Password should be same"))
            return
        }
        
        FirebaseAuthentication.shared.signUp(email: email, password: password, username: username) {[weak self] message in
            switch message{
            case .didSignUpSuccessful:
                print("sign up successful")
                self?.changeHandler?(.didSignUpSuccessful)
            case .didErrorOccurred(let error):
                print("Sign Up Error: \(error.localizedDescription)")
                self?.changeHandler?(.didErrorOccurred(error))
            default:
                break
            }
        }
    }
    
}
