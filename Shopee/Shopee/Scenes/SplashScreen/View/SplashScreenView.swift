//
//  SplashScreenView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 25.10.2022.
//

import UIKit

final class SplashScreenView: UIView{
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            backgroundColor = .white
        }
        
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 88),
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        

    }
    
    func logoAnimation(){
        indicator.alpha = 0
        let originalTransform = logoImageView.transform
        let scaledTransform = originalTransform.scaledBy(x: 10.0, y: 10.0)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.7, animations: {
            self.logoImageView.transform = scaledAndTranslatedTransform
       })
    }
    
    var isLogoVisible: Bool = true {
        didSet{
            self.logoImageView.alpha = 0
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
