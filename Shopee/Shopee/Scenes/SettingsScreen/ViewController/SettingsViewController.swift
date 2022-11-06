//
//  SettingsViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 6.11.2022.
//

import UIKit

final class SettingsViewController: UIViewController, AlertPresentable{
    enum PhotoUploadMessage{
        case didErrorOccurred(_ error: Error)
        case didUploadedSuccessfully(_ url: String)
    }
    
    private let settingsView = SettingsView()
    private let settingsViewModel = SettingsViewModel()

    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = settingsView
        
        guard let currentUser = settingsViewModel.user else {return}
        settingsView.username = currentUser.username
        settingsView.email = currentUser.email
        if let profileImage = currentUser.profilePicture{
            if (profileImage == "") {
                settingsView.image = nil
            }else{
                KingfisherOperations.shared.downloadProfileImage(url: profileImage, imageView: settingsView.profileImageView, size: 150)
            }
        }
        
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        settingsView.signInSingUpButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        settingsView.changeProfileImageButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
        settingsView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @objc func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        goBackToProfilePage()
    }
    
    @objc func saveChanges(){
        settingsView.showIndicator = true
        if isEmailValid(){
            let controlThePage = settingsViewModel.controlPassword(password: settingsView.password, reTypedpassword: settingsView.reTypedPassword)
            
            switch controlThePage{
            case .didErrorOccurred(let error):
                settingsView.showIndicator = false
                showAlert(title: "Error", message: error)
            case .saveWithoutPassword:
                saveUserChanges(willPasswordSave: false)
            case .saveWithPassword:
                saveUserChanges(willPasswordSave: true)
            }
        }
    }
    
    // TODO: -Refactor it and write it in viewmodel. It is spagetti code right now
    func saveUserChanges(willPasswordSave: Bool){
        guard let currentUser = settingsViewModel.user else {return}
        guard let password = settingsView.password else{return}
        
        saveImage {[weak self] message in
            switch message{
            case .didErrorOccurred(let error):
                self?.settingsView.showIndicator = false
                self?.showError(error)
            case .didUploadedSuccessfully(let url):
                let user = UserProfile(id: currentUser.id, username: self?.settingsView.username, email: currentUser.email, profilePicture: url)
                self?.settingsViewModel.updateUserInfo(user: user){[weak self] message in
                    switch message{
                    case .didErrorOccurred(let error):
                        self?.settingsView.showIndicator = false
                        self?.showError(error)
                    case .didUserSavedInSuccessfully:
                        if willPasswordSave{
                            FirebaseAuthentication.shared.updatePassword(password: password) {[weak self] message in
                                switch message{
                                case .didErrorOccurred(let error):
                                    self?.settingsView.showIndicator = false
                                    self?.showError(error)
                                default:
                                    self?.settingsView.showIndicator = false
                                    print("Password updated")
                                }
                            }
                        }
                        
                        
                        FirebaseFirestoreManagement.shared.fetchCurrentUserInfo {[weak self] message in
                            switch message{
                            case .didUserFetchedSuccessfully(let user):
                                self?.settingsView.showIndicator = false
                                FirebaseAuthentication.shared.userInfo = user
                                self?.showAlert(title: "Saved", message: "Your informations are updated."){_ in
                                    self?.goBackToProfilePage()
                                }
                            default:
                                self?.settingsView.showIndicator = false
                                break
                            }
                        }
                    }
                }
            }
        }
    }
    
    func goBackToProfilePage(){
        presentingViewController?.viewWillAppear(true)
        dismiss(animated: true)
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


extension SettingsViewController {
    func saveImage(completion: @escaping(PhotoUploadMessage) -> Void){
        guard let image = settingsView.profileImageView.image else{return}
        guard let data = image.pngData() else {return}
        
        FirebaseStorage.shared.uploadProfileImage(imageData: data) {[weak self] message in
            switch message{
            case .didErrorOccurred(let error):
                completion(.didErrorOccurred(error))
            case .didImageUploadedSuccessfully(let url):
                completion(.didUploadedSuccessfully(url))
            }
        }
    }
}

extension SettingsViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.settingsView.image = image
    }
}

