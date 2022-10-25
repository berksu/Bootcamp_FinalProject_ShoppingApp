//
//  SplashScreenViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 25.10.2022.
//

import UIKit

class SplashScreenViewController: UIViewController {

    let splashView = SplashScreenView()

    override func loadView() {
        super.loadView()
        view = splashView
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute: {self.splashView.animate()})
    }
}

