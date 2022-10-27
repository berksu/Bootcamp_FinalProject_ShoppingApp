//
//  AuthenticationViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 26.10.2022.
//

import UIKit

final class AuthenticationViewController: UIViewController{
    
    let authenticationView = AuthenticationView()
    
    @objc func forgotPasswordTapped(sender: UIButton){
        sender.showAnimation {
            let resetPasswordViewController = ResetPasswordViewController()
            self.navigationController?.modalPresentationStyle = .formSheet
            self.navigationController?.present(resetPasswordViewController, animated: true)
          }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = authenticationView
        
        authenticationView.signInView.forgetPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
    }
}
