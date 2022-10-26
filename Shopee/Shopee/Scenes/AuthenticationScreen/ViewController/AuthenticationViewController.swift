//
//  AuthenticationViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 26.10.2022.
//

import UIKit

final class AuthenticationViewController: UIViewController{
    
    let authenticationView = AuthenticationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = authenticationView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
    }
}
