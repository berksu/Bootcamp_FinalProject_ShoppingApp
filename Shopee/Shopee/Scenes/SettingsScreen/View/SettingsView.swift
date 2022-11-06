//
//  SettingsView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 6.11.2022.
//

import UIKit

final class SettingsView: UIView{
    
    var email: String?{
        get{
            emailTextField.text
        }
        set{
            guard let email = newValue else{return}
            emailTextField.text = email
        }
    }
    
    var username: String?{
        get{
            usernameTextField.text
        }
        set{
            guard let username = newValue else{return}
            usernameTextField.text = username
        }
    }
    
    var password: String?{
        get{
            passwordTextField.text
        }
        set{
            guard let password = newValue else{return}
            passwordTextField.text = password
        }
    }
    
    var reTypedPassword: String?{
        get{
            reTypedpasswordTextField.text
        }
        set{
            guard let reTypedPassword = newValue else{return}
            reTypedpasswordTextField.text = reTypedPassword
        }
    }
    
    var image: UIImage?{
        didSet{
            if let image = image {
                profileImageView.image = image
                profileImageView.layer.borderWidth = 1
                profileImageView.layer.masksToBounds = false
                profileImageView.layer.borderColor = UIColor.black.cgColor
                profileImageView.layer.cornerRadius = 75
                profileImageView.clipsToBounds = true
            }else{
                profileImageView.image = UIImage(named: "profileImagePlaceholder")
            }
        }
    }
    
    var showIndicator: Bool = false{
        didSet{
            if showIndicator{
                alpha = 0.2
                indicator.isHidden = false
                indicator.startAnimating()
            }else{
                alpha = 1
                indicator.isHidden = true
                indicator.stopAnimating()
            }
        }
    }
    
    var backButton: UIButton = {
       var button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        return button
    }()
    
    let profileImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileImagePlaceholder")
        imageView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let changeProfileImageButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addCircle"), for: .normal)
        button.imageView?.tintColor = .black
        button.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        return button
    }()
    
    private lazy var emailLabel = createLabel(text: "Email")
    private lazy var usernameLabel = createLabel(text: "Username")
    private lazy var passwordLabel = createLabel(text: "Password")
    private lazy var reTypedPasswordLabel = createLabel(text: "Re-Typed")

    lazy var emailTextField = createTextField(text: "email", isSecureTextField: false, isEditable: false)
    lazy var usernameTextField = createTextField(text: "username", isSecureTextField: false, isEditable: true)
    lazy var passwordTextField = createTextField(text: "(To not change password, keep it blank)", isSecureTextField: true, isEditable: true)
    lazy var reTypedpasswordTextField = createTextField(text: "(To not change password, keep it blank)", isSecureTextField: true, isEditable: true)

    private let verticalStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private(set) var signInSingUpButton: UIButton = {
        var button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.tag = 0
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 15)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let indicator: UIActivityIndicatorView = {
       let indicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
       indicatorView.startAnimating()
       return indicatorView
   }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .white
        
        verticalStackView.addArrangedSubview(emailLabel)
        verticalStackView.addArrangedSubview(emailTextField)
        verticalStackView.addArrangedSubview(usernameLabel)
        verticalStackView.addArrangedSubview(usernameTextField)
        verticalStackView.addArrangedSubview(passwordLabel)
        verticalStackView.addArrangedSubview(passwordTextField)
        verticalStackView.addArrangedSubview(reTypedPasswordLabel)
        verticalStackView.addArrangedSubview(reTypedpasswordTextField)
        
        setBackButton()
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
        
        addSubview(changeProfileImageButton)
        changeProfileImageButton.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.trailing.equalTo(profileImageView.snp.trailing)
        }
        
        addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(32)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
        
        addSubview(signInSingUpButton)
        signInSingUpButton.snp.makeConstraints { make in
            make.top.equalTo(verticalStackView.snp.bottom).offset(32)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.height.equalTo(40)
        }
        
        addSubview(indicator)
        indicator.isHidden = true
        indicator.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide.snp.center)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsView{
    func createTextField(text: String, isSecureTextField: Bool, isEditable: Bool) -> UITextField{
        let textfield =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textfield.backgroundColor = .white
        textfield.textColor = .black
        textfield.leftViewMode = .always
        textfield.leftView = spacerView
        if !isSecureTextField{
            textfield.text = text
        }else{
            textfield.placeholder = text
        }
        textfield.font = UIFont(name: "Inter-Regular", size: 15)
        textfield.borderStyle = UITextField.BorderStyle.roundedRect
        textfield.layer.cornerRadius = 8
        textfield.layer.borderColor = UIColor(named: "authenticationTextField")?.cgColor
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = isSecureTextField
        textfield.isUserInteractionEnabled = isEditable
        return textfield
    }
    
    func createLabel(text: String) -> UILabel{
        let label = UILabel()
        label.textColor = .black
        label.text = text
        label.font = UIFont(name: "Inter-Bold", size: 15)
        return label
    }
}

extension SettingsView{
    func setBackButton(){
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(self.snp.leading).offset(16)
        }
    }
}
