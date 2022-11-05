//
//  SplashScreenViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 25.10.2022.
//

import UIKit

class SplashScreenViewController: UIViewController {

    private let splashView = SplashScreenView()

    override func loadView() {
        super.loadView()
        view = splashView
//        FirebaseAuthentication.shared.signOut { _ in
//            
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseFirestoreManagement.shared.fetchCurrentUserInfo { message in
            switch message{
            case .didUserFetchedSuccessfully(let user):
                FirebaseAuthentication.shared.userInfo = user
            default:
                break
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute: {self.animate()})
    }
    
    func animate(){
        splashView.logoAnimation()
       
        UIView.animate(withDuration: 1.2, animations: {self.splashView.isLogoVisible = false }) { done in
            if done{
                let authenticationViewController = OnBoardingViewController()
                self.navigationController?.pushViewController(authenticationViewController, animated: false)
            }
        }
   }
}

