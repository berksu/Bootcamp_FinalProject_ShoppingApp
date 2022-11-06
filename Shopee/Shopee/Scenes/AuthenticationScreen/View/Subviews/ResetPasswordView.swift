//
//  ResetPasswordView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 28.10.2022.
//

import UIKit

final class ResetPasswordView: UIView{
    
    var email: String?{
        emailTextView.text
    }
    
    var indicatorHidden: Bool = true{
        didSet{
            indicatorView.isHidden = indicatorHidden
            stackView.alpha = indicatorHidden ? 1.0:0.5
        }
    }
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "forgotPassword")?.withColor(.black)
        imageView.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.screenWidth * 0.5)
            make.height.equalTo(CGFloat.screenWidth * 0.5)
        }
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password"
        label.textColor = .black
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
        return textfield
    }
    
    private var emailTextView = UITextField()
    private var stackView = UIStackView()
    
    private(set) var sendMailButton: UIButton = {
        var button = UIButton()
        button.setTitle("Send Mail", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1.0
        button.backgroundColor = .blue
        return button
    }()
    
    private var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.isHidden = true
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        emailTextView = createTextFiald(placeholder: "Enter email", isSecureTextField: false)
        
        stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                   emailTextView,
                                                   sendMailButton])
        stackView.axis = .vertical
        stackView.spacing = 32.0
        
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(128)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(iconImageView.snp.bottom).offset(32)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.leading.equalTo(self.snp.leading).offset(16)
        }
        
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
