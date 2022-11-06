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

    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = settingsView
        
        guard let currentUser = settingsViewModel.user else {return}
        settingsView.username = currentUser.username
        settingsView.email = currentUser.email
        settingsView.image = UIImage(named: "profileImagePlaceholder")
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        settingsView.signInSingUpButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        settingsView.changeProfileImageButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @objc func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
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
    
    // TODO: -Refactor it and write it in viewmodel
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
                            self?.presentingViewController?.viewWillAppear(true)
                            self?.dismiss(animated: true)
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
    
}

extension SettingsViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.settingsView.image = image
    }
}

