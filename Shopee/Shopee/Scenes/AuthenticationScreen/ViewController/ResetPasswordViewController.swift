//
//  ResetPasswordViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 28.10.2022.
//

import UIKit

final class ResetPasswordViewController: UIViewController, AlertPresentable{
    
    let resetPasswordView = ResetPasswordView()
    
    @objc func sendMailToUser(_ sender: UIButton){
        resetPasswordView.indicatorHidden = false
        
        sender.showAnimation {
            guard let email = self.resetPasswordView.email else {return}
        
            FirebaseAuthentication.shared.forgotPassword(email: email) {[weak self] message in
                switch message{
                case .didForgetMessageSentSuccessful:
                    self?.resetPasswordView.indicatorHidden = true
                    self?.showAlert(title: "Email sent")
                case .didErrorOccurred(let error):
                    self?.resetPasswordView.indicatorHidden = true
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                default:
                    break
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = resetPasswordView
        
        resetPasswordView.sendMailButton.addTarget(self, action: #selector(sendMailToUser), for: .touchUpInside)
    }
}
