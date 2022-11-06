//
//  SettingsViewModel.swift
//  Shopee
//
//  Created by Berksu Kısmet on 6.11.2022.
//

import UIKit

final class SettingsViewModel{
    enum SettingsViewModelChanges{
        case didUserSavedInSuccessfully
        case didErrorOccurred(_ error: Error)
    }
    
    enum PasswordControl{
        case saveWithoutPassword
        case saveWithPassword
        case didErrorOccurred(_ error: String)
    }


    var changeHandler: ((SettingsViewModelChanges) -> Void)?
    
    var user: UserProfile?{
        FirebaseAuthentication.shared.userInfo
    }
    
    func updateUserInfo(user: UserProfile, completion: @escaping(SettingsViewModelChanges)-> Void){
        FirebaseFirestoreManagement.shared.saveUser(user: user) { message in
            switch message{
            case .didErrorOccurred(let error):
                completion(.didErrorOccurred(error))
            case .didUserSavedInSuccessfully:
                completion(.didUserSavedInSuccessfully)
            default:
                break
            }
        }
    }
    
    func fetchPhoto(imageView: UIImageView){
        
    }
    
    func controlPassword(password: String?, reTypedpassword: String?) -> PasswordControl{
        guard let password = password else{return .didErrorOccurred("Password cannot be readed")}
        guard let reTypedpassword = reTypedpassword else{return .didErrorOccurred("Re-Typed Password cannot be readed")}
        
        if password.count == 0 && reTypedpassword.count == 0{
            return .saveWithoutPassword
        }else{
            if !password.isValidPassword{
                return .didErrorOccurred("Password is not valid. Password should have 8 characters(At least one number and 1 special character)")
            }
            
            if password != reTypedpassword{
                return .didErrorOccurred("Password and reTyped password should be same")
            }
            
            if password == reTypedpassword{
                return .saveWithPassword
            }
            return .didErrorOccurred("Something went wrong")
        }
    }
}
