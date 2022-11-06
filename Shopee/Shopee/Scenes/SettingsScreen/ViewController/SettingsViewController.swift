//
//  SettingsViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 6.11.2022.
//

import UIKit

final class SettingsViewController: UIViewController, AlertPresentable{
   
    private let settingsView = SettingsView()
    private let settingsViewModel = SettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = settingsView
        
        settingsView.signInSingUpButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let currentUser = settingsViewModel.user else {return}
        settingsView.username = currentUser.username
        settingsView.email = currentUser.email
        KingfisherOperations.shared.downloadProfileImage(url: "https://dl.memuplay.com/new_market/img/com.vicman.newprofilepic.icon.2022-06-07-21-33-07.png", imageView: settingsView.profileImageView )
    }
    
    @objc func saveChanges(){
        if isEmailValid(){
            let controlThePage = settingsViewModel.controlPassword(password: settingsView.password, reTypedpassword: settingsView.reTypedPassword)
            
            switch controlThePage{
            case .didErrorOccurred(let error):
                showAlert(title: "Error", message: error)
            case .saveWithoutPassword:
                saveUserChanges(willPasswordSave: false)
            case .saveWithPassword:
                saveUserChanges(willPasswordSave: true)
            }
        }
    }
    
    func saveUserChanges(willPasswordSave: Bool){
        guard let currentUser = settingsViewModel.user else {return}
        guard let password = settingsView.password else{return}

        let user = UserProfile(id: currentUser.id, username: settingsView.username, email: currentUser.email, profilePicture: "")
        settingsViewModel.updateUserInfo(user: user){[weak self] message in
            switch message{
            case .didErrorOccurred(let error):
                self?.showError(error)
            case .didUserSavedInSuccessfully:
                if willPasswordSave{
                    FirebaseAuthentication.shared.updatePassword(password: password) {[weak self] message in
                        switch message{
                        case .didErrorOccurred(let error):
                            self?.showError(error)
                        default:
                            print("Password updated")
                        }
                    }
                }
                
                
                FirebaseFirestoreManagement.shared.fetchCurrentUserInfo {[weak self] message in
                    switch message{
                    case .didUserFetchedSuccessfully(let user):
                        FirebaseAuthentication.shared.userInfo = user
                        self?.showAlert(title: "Saved", message: "Your informations are updated."){_ in
                            self?.viewWillDisappear(true)
                        }
                    default:
                        break
                    }
                }
            }
        }
    }
    
    func isEmailValid() -> Bool{
        guard let email = settingsView.email else{return false}
        if !email.isValidEmail{
            showAlert(title: "Error", message: "Email is not valid")
            return false
        }else{
            return true
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.viewWillAppear(true)
        dismiss(animated: true)
    }
}
