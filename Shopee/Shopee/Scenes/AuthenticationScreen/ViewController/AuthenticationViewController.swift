//
//  AuthenticationViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 26.10.2022.
//

import UIKit

final class AuthenticationViewController: UIViewController, AlertPresentable{
    
    enum SegmentMenuItem: Int{
        case signIn = 0
        case signUp = 1
    }
    
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
        
        switch SegmentMenuItem(rawValue: sender.tag){
        case .signIn:
            authenticationViewModel.signIn(email: authenticationView.signInView.email, password: authenticationView.signInView.password)
        case .signUp:
            authenticationViewModel.signUp(email: authenticationView.signUpView.email, password: authenticationView.signUpView.password, reTypedPassword: authenticationView.signUpView.passwordReTyped, username: authenticationView.signUpView.username)
        default:
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        
        authenticationView.signInView.forgetPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        authenticationView.signInSingUpButton.addTarget(self, action: #selector(sigInSignUpButton), for: .touchUpInside)
        
        authenticationViewModel.changeHandler = {[weak self] change in
            guard let self = self else{return}
            self.authenticationView.indicatorHidden = true
            switch change {
            case .didErrorOccurred(let error):
                self.showAlert(title: error.localizedDescription)
            case .didSignInSuccessful:
                self.showAlert(title: "Signed In") { _ in
                    self.navigateToTabBar()
                }
            case .didSignUpSuccessful:
                self.showAlert(title: "Signed Up"){ _ in
                    self.navigateToTabBar()
                }
            case .didErrorOccurredAboutUserInputs(let errorTitle, let errorMessage):
                self.showAlert(title: errorTitle, message: errorMessage)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        if authenticationViewModel.isSignedIn{
            navigateToTabBar()
        }else{
            view = authenticationView
        }
    }

    func navigateToTabBar(){
        DispatchQueue.main.async {
            self.authenticationViewModel.fetchCurrentUser()
            let tabBarViewController = TabBarViewController()
            tabBarViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(tabBarViewController, animated: false)
        }
    }
    
}
