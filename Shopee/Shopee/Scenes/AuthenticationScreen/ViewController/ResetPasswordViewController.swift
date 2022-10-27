//
//  ResetPasswordViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 28.10.2022.
//

import UIKit

final class ResetPasswordViewController: UIViewController{
    
    let resetPasswordView = ResetPasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = resetPasswordView
    }
    
}
