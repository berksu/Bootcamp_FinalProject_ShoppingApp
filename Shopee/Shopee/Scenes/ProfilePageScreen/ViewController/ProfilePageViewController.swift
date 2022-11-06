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
        profilePageView.settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.settingsTapped(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let currentUser = profilePageViewModel.user else {return}
        profilePageView.username = currentUser.username
        profilePageView.email = currentUser.email
        profilePageView.image = UIImage(named: "profileImagePlaceholder")
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code        
        self.showAlert(title:"Sign Out", message: "Are you sure ?",cancelButtonTitle: "Cancel") { _ in
            FirebaseAuthentication.shared.signOut {[weak self] message in
                switch message{
                case .didSignOutSuccessful:
                    self?.dismiss(animated: true)
                case .didErrorOccurred(let error):
                    self?.showError(error)
                default:
                    break
                }
            }
        }
    }
    
    @objc func settingsTapped(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        let settingsViewController = SettingsViewController()
        settingsViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(settingsViewController, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !profilePageView.signOutView.isGradientAdded{
            let colors = [UIColor.red.withAlphaComponent(0.1).cgColor, UIColor.red.withAlphaComponent(0.7).cgColor]
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = colors
            gradientLayer.cornerRadius = 10
            gradientLayer.frame = self.profilePageView.signOutView.bounds // New line
            profilePageView.signOutView.layer.insertSublayer(gradientLayer, at: 0)
            profilePageView.signOutView.isGradientAdded = true
        }
    }

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ViewControllerPreview_Previews: PreviewProvider {

    static var previews: some View {
        ViewControllerPreview {
            ProfilePageViewController()
        }
    }
}

#endif
