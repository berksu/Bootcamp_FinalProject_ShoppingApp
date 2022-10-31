//
//  ProfilePageViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 31.10.2022.
//

import UIKit

final class ProfilePageViewController: UIViewController,AlertPresentable{
    
    let profilePageView = ProfilePageView()
    let profilePageViewModel = ProfilePageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        view = profilePageView
        profilePageView.signOutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))

        guard let currentUser = profilePageViewModel.user else {return}
        profilePageView.username = currentUser.username
        profilePageView.email = currentUser.email
        KingfisherOperations.shared.downloadProfileImage(url: "https://dl.memuplay.com/new_market/img/com.vicman.newprofilepic.icon.2022-06-07-21-33-07.png", imageView: profilePageView.profileImageView )
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code        
        self.showAlert(title:"Sign Out", message: "Are you sure ?",cancelButtonTitle: "Cancel") { _ in
            FirebaseAuthentication.shared.signOut {[weak self] message in
                switch message{
                case .didSignOutSccessful:
                    self?.dismiss(animated: true)
                case .didErrorOccurred(let error):
                    self?.showError(error)
                default:
                    break
                }
            }
        }

    }
}
