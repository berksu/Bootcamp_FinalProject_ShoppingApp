//
//  SignInView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 27.10.2022.
//

import UIKit

final class SignInView: UIView{
    
    var email: String?{
        emailTextView.text
    }
    
    var password: String?{
        passwordTextField.text
    }
    
    private var emailTextView: UITextField = UITextField()
    private var passwordTextField: UITextField = UITextField()

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
        textfield.layer.cornerRadius = 8
        textfield.layer.borderColor = UIColor(named: "authenticationTextField")?.cgColor
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = isSecureTextField
        return textfield
    }
    
    var forgetPasswordButton: UIButton = {
        var button = UIButton()
        button.setTitle("Forgot Password", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(.red, for: .normal)
        button.underline()
        return button
    }()
    
    private var forgetPasswordButtonView: UIView{
        let view = UIView()
        let labelSize = forgetPasswordButton.titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
        view.addSubview(forgetPasswordButton)
        forgetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalTo(labelSize.width)
        }
        return view
    }
    

    private var showPasswordButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "showPassword"), for: .normal)
        button.imageView?.tintColor = .black
        button.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        button.addTarget(self, action: #selector(touchDownEvent), for: .touchDown)
        button.addTarget(self, action: #selector(touchUpEvent), for: [.touchUpInside, .touchUpOutside])

        return button
    }()

    @objc func touchDownEvent(_ sender: AnyObject) {
        passwordTextField.isSecureTextEntry = false
    }

    @objc func touchUpEvent(_ sender: AnyObject) {
        passwordTextField.isSecureTextEntry = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        emailTextView = createTextField(placeholder: "Enter email", isSecureTextField: false)
        passwordTextField = createTextField(placeholder: "Enter password", isSecureTextField: true)
        
        passwordTextField.addSubview(showPasswordButton)
        showPasswordButton.snp.makeConstraints { make in
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(-16)
            make.centerY.equalTo(passwordTextField.snp.centerY)
        }
        let stackView = UIStackView(arrangedSubviews: [emailTextView,
                                                       passwordTextField,
                                                       forgetPasswordButtonView])
        

        
        stackView.axis = .vertical
        stackView.spacing = 16.0
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        
        emailTextView.text = "berksukismet@gmail.com"
        passwordTextField.text = "Test1234."
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
