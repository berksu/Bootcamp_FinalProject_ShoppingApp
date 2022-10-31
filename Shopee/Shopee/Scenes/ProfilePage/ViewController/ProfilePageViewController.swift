//
//  ProfilePageViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 31.10.2022.
//

import UIKit

final class ProfilePageViewController: UIViewController{
    
    let profilePageView = ProfilePageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        view = profilePageView
    }
}
