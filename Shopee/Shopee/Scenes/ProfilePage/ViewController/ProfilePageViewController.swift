//
//  ProfilePageViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 31.10.2022.
//

import UIKit

final class ProfilePageViewController: UIViewController{
    
    let profilePageView = ProfilePageView()
    let profilePageViewModel = ProfilePageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        view = profilePageView
        
        guard let currentUser = profilePageViewModel.user else {return}
        profilePageView.username = currentUser.username
        profilePageView.email = currentUser.email
        KingfisherOperations.shared.downloadProfileImage(url: "https://dl.memuplay.com/new_market/img/com.vicman.newprofilepic.icon.2022-06-07-21-33-07.png", imageView: profilePageView.profileImageView )
        
    }
}
