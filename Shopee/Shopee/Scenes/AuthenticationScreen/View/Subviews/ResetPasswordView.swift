//
//  ResetPasswordView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 28.10.2022.
//

import UIKit

final class ResetPasswordView: UIView{
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private func createTextFiald(placeholder: String, isSecureTextField: Bool) -> UITextField{
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
    
    
    private let sendMailButton: UIButton = {
        var button = UIButton()
        button.setTitle("Send Mail", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1.0
        button.backgroundColor = .blue
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            backgroundColor = .white
        }
        
        let emailTextView = createTextFiald(placeholder: "Enter email", isSecureTextField: false)
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       emailTextView,
                                                       sendMailButton])
        

        stackView.axis = .vertical
        stackView.spacing = 16.0
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(128)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.leading.equalTo(self.snp.leading).offset(16)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
