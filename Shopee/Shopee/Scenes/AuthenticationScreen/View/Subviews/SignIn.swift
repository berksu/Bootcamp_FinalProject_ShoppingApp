//
//  SignIn.swift
//  Shopee
//
//  Created by Berksu Kısmet on 27.10.2022.
//

import UIKit

final class SignIn: UIView{
    
    func createTextField(placeholder: String, isSecureTextField: Bool) -> UITextField{
        let textfield =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textfield.leftViewMode = .always
        textfield.leftView = spacerView
        textfield.placeholder = placeholder
        textfield.font = UIFont.systemFont(ofSize: 15)
        textfield.borderStyle = UITextField.BorderStyle.roundedRect
        textfield.layer.cornerRadius = 8
        textfield.layer.borderWidth = 0.5
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = isSecureTextField
        //sampleTextField.keyboardType = UIKeyboardType.default
        //sampleTextField.returnKeyType = UIReturnKeyType.done
        //sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        //sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textfield
    }
    
    
    var forgetPasswordButtonView: UIView{
        var view = UIView()
        var button = UIButton()
        button.setTitle("Forgot Password", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(.red, for: .normal)
        button.underline()
        let labelSize = button.titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalTo(labelSize.width)
        }
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let emailTextView = createTextField(placeholder: "Enter email", isSecureTextField: false)
        let passwordTextField = createTextField(placeholder: "Enter password", isSecureTextField: true)

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
        
//        let emailTextView = createTextField(placeholder: "Enter email", isSecureTextField: false)
//        addSubview(emailTextView)
//        emailTextView.snp.makeConstraints { make in
//            make.top.equalTo(self.snp.top)
//            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
//            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
//        }
//
//        let passwordTextField = createTextField(placeholder: "Enter password", isSecureTextField: true)
//        addSubview(passwordTextField)
//        passwordTextField.snp.makeConstraints { make in
//            make.top.equalTo(emailTextView.snp.bottom).offset(16)
//            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
//            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
//            make.bottom.equalTo(self.snp.bottom)
//        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
