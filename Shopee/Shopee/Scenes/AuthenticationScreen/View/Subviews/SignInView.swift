//
//  SignInView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 27.10.2022.
//

import UIKit

final class SignInView: UIView{
    
    func createTextField(placeholder: String, isSecureTextField: Bool) -> UITextField{
        let textfield =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
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
        //sampleTextField.keyboardType = UIKeyboardType.default
        //sampleTextField.returnKeyType = UIReturnKeyType.done
        //sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        //sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
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
        //button.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
