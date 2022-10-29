//
//  AuthenticationViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 26.10.2022.
//

import UIKit

final class AuthenticationViewController: UIViewController, AlertPresentable{
    
    let authenticationView = AuthenticationView()
    let authenticationViewModel = AuthenticationViewModel()
    
    @objc func forgotPasswordTapped(sender: UIButton){
        sender.showAnimation {
            let resetPasswordViewController = ResetPasswordViewController()
            self.navigationController?.modalPresentationStyle = .formSheet
            self.navigationController?.present(resetPasswordViewController, animated: true)
          }
    }
    
    @objc func sigInSignUpButton(sender: UIButton){
        authenticationView.indicatorHidden = false
        
        if sender.tag == 0{
            authenticationViewModel.signIn(email: authenticationView.signInView.email, password: authenticationView.signInView.password)
        }else{
            authenticationViewModel.signUp(email: authenticationView.signUpView.email, password: authenticationView.signUpView.password, reTypedPassword: authenticationView.signUpView.passwordReTyped, username: authenticationView.signUpView.username)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = authenticationView
        
        authenticationView.signInView.forgetPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        authenticationView.signInSingUpButton.addTarget(self, action: #selector(sigInSignUpButton), for: .touchUpInside)
        
        authenticationViewModel.changeHandler = {[weak self] change in
            switch change {
            case .didErrorOccurred(let error):
                self?.authenticationView.indicatorHidden = true
                self?.showAlert(title: error.localizedDescription)
            case .didSignInSuccessful:
                self?.authenticationView.indicatorHidden = true
                self?.showAlert(title: "Signed In")
            case .didSignUpSuccessful:
                self?.authenticationView.indicatorHidden = true
                self?.showAlert(title: "Signed Up")
            case .didErrorOccurredAboutUserInputs(let errorTitle, let errorMessage):
                self?.authenticationView.indicatorHidden = true
                self?.showAlert(title: errorTitle, message: errorMessage)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
        if authenticationViewModel.isSignedIn{
            let tabBarViewController = TabBarViewController()
            self.navigationController?.pushViewController(tabBarViewController, animated: false)
        }
    }
}
