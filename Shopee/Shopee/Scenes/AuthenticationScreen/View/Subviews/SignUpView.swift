//
//  SignUp.swift
//  Shopee
//
//  Created by Berksu Kısmet on 27.10.2022.
//

import UIKit

final class SignUpView: UIView{
    
    var username: String?{
        usernameTextField.text
    }
    
    var email: String?{
        emailTextView.text
    }
    
    var password: String?{
        passwordTextField.text
    }
    
    var passwordReTyped: String?{
        passwordRepeatTextField.text
    }
    
    private var usernameTextField = UITextField()
    private var emailTextView = UITextField()
    private var passwordTextField = UITextField()
    private var passwordRepeatTextField = UITextField()

    
    func createTextField(placeholder: String, isSecureTextField: Bool) -> UITextField{
        let textfield =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textfield.backgroundColor = .white
        textfield.textColor = .black
        textfield.leftViewMode = .always
        textfield.leftView = spacerView
        textfield.placeholder = placeholder
        textfield.font = UIFont.systemFont(ofSize: 15)
        textfield.borderStyle = UITextField.BorderStyle.roundedRect
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = isSecureTextField
        return textfield
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        usernameTextField = createTextField(placeholder: "Enter username", isSecureTextField: false)
        addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
        
        emailTextView = createTextField(placeholder: "Enter email", isSecureTextField: false)
        addSubview(emailTextView)
        emailTextView.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
        
        passwordTextField = createTextField(placeholder: "Enter password", isSecureTextField: true)
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextView.snp.bottom).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
        
        passwordRepeatTextField = createTextField(placeholder: "Re-type password", isSecureTextField: true)
        addSubview(passwordRepeatTextField)
        passwordRepeatTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
