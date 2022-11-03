//
//  BasketScreenViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 3.11.2022.
//

import UIKit

final class BasketScreenViewController: UIViewController{
    private let basketScreenView = BasketScreenView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view = basketScreenView
        
        basketScreenView.backButtonController.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped(sender: UIButton){
        dismiss(animated: true)
    }
}
