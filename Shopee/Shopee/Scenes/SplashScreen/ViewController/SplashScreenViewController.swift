//
//  SplashScreenViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 25.10.2022.
//

import UIKit

class SplashScreenViewController: UIViewController {

    //    let splashView = SplashScreenView()
        
        private let logoImageView: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
            imageView.image = UIImage(named: "splashScreenLogo")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()

        private let indicator: UIActivityIndicatorView = {
            let indicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            indicatorView.startAnimating()
            return indicatorView
        }()

        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            if #available(iOS 13.0, *) {
                view.backgroundColor = .systemBackground
            } else {
                // Fallback on earlier versions
            }

            view.addSubview(logoImageView)
            logoImageView.center = view.center

            view.addSubview(indicator)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                indicator.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 88),
                indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            //logoImageView.center = view.center
            DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute: {self.animateView()})
        }

        func animateView(){
            indicator.alpha = 0

            UIView.animate(withDuration: 1) {
                let size = self.view.frame.size.width * 3
                let diffX = size - self.view.frame.size.width
                let diffY = self.view.frame.size.height - size
                
                self.logoImageView.frame = CGRect(x: -(diffX/2),
                                                  y: diffY/2,
                                                  width: size,
                                                  height: size)
            }

            UIView.animate(withDuration: 1.5) {
                self.logoImageView.alpha = 0
            }
        }

}

