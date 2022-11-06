//
//  ProfilePageView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 31.10.2022.
//

import UIKit

final class ProfilePageView: UIView{
    
    var username: String?{
        didSet{
            userNameLabel.text = username
        }
    }
    
    var email: String?{
        didSet{
            userEmailLabel.text = email
        }
    }
    
    var image: UIImage?{
        didSet{
            if let image = image {
                profileImageView.image = image
                profileImageView.layer.borderWidth = 1
                profileImageView.layer.masksToBounds = false
                profileImageView.layer.borderColor = UIColor.black.cgColor
                profileImageView.layer.cornerRadius = 40
                profileImageView.clipsToBounds = true
            }else{
                profileImageView.image = UIImage(named: "profileImagePlaceholder")
            }
        }
    }
    
    private let userNameLabel = {
       let label = UILabel()
        label.text = "Username"
        label.font = UIFont(name: "Inter-Bold", size: 28)
        label.textColor = .black
        return label
    }()
    
    private let userEmailLabel = {
       let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "Inter-Regular", size: 14)
        label.textColor = UIColor(rgb: 0x808080, a: 1)
        return label
    }()
    
    private let userNameAndEmailStack:UIStackView = {
        let stack = UIStackView()
        stack.spacing = 4
        stack.axis = .vertical
        return stack
    }()
    
    let profileImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileImagePlaceholder")
        imageView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        return imageView
    }()
    
    private let profileInformationStack:UIStackView = {
        let stack = UIStackView()
        stack.spacing = 32
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()
    
    private let allProfilePageStack:UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20
        stack.axis = .vertical
        return stack
    }()
    
    let settingsView: GradientUIView = {
        let view = ProfileViewCustomButtonView(title: "Settings", description: "Password, Contact")
        view.snp.makeConstraints { make in
            make.width.equalTo(ProfilePageView.LayoutConstraints.widthOfCustomButon)
            make.height.equalTo(ProfilePageView.LayoutConstraints.heightOfCustomButon)
        }
        return view
    }()
    
    var signOutView: GradientUIView = {
        let view = ProfileViewCustomButtonView(title: "Sign Out", description: "Please don't go")
        view.snp.makeConstraints { make in
            make.width.equalTo(ProfilePageView.LayoutConstraints.widthOfCustomButon)
            make.height.equalTo(ProfilePageView.LayoutConstraints.heightOfCustomButon)
        }
        return view
    }()
    
    init(){
        super.init(frame: .zero)
        backgroundColor = .white
        
        userNameAndEmailStack.addArrangedSubview(userNameLabel)
        userNameAndEmailStack.addArrangedSubview(userEmailLabel)
        
        profileInformationStack.addArrangedSubview(profileImageView)
        profileInformationStack.addArrangedSubview(userNameAndEmailStack)

        allProfilePageStack.addArrangedSubview(profileInformationStack)
        allProfilePageStack.addArrangedSubview(settingsView)
        allProfilePageStack.addArrangedSubview(signOutView)

        allProfilePageStack.setCustomSpacing(40, after: profileInformationStack)
        
        addSubview(allProfilePageStack)
        allProfilePageStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(18)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfilePageView{
    struct LayoutConstraints{
        static let widthOfCustomButon = CGFloat.screenWidth * 0.8
        static let heightOfCustomButon = CGFloat.screenWidth * 0.2
    }
}
