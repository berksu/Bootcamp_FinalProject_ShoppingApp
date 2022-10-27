//
//  AuthenticaitionView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 26.10.2022.
//

import UIKit

final class AuthenticationView: UIView{
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.tintColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private var stackView = UIStackView()
    
    private var signInorUpView: UIView = SignIn(){
        willSet{
            stackView.removeArrangedSubview(signInorUpView)
            signInorUpView.removeFromSuperview()
            stackView.insertArrangedSubview(newValue, at: 2)
        }
    }
    
    
    // MARK: - Define Segment Control
    private let segmentedControl: UISegmentedControl = {
        let items = ["Sign In", "Sign Up"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
//        if #available(iOS 13.0, *) {
//            segmentedControl.backgroundColor = UIColor.black
//            segmentedControl.layer.borderColor = UIColor.white.cgColor
//            segmentedControl.selectedSegmentTintColor = UIColor.white
//            segmentedControl.layer.borderWidth = 1
//
//             let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//            segmentedControl.setTitleTextAttributes(titleTextAttributes, for:.normal)
//
//             let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
//            segmentedControl.setTitleTextAttributes(titleTextAttributes1, for:.selected)
//         } else {
//                     // Fallback on earlier versions
//       }
        return segmentedControl
    }()
    
    
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
            switch (segmentedControl.selectedSegmentIndex) {
            case 0:
                titleLabel.text = "Sign In"
                signInorUpView = SignIn()
            case 1:
                titleLabel.text = "Sign Up"
                signInorUpView = SignUp()
            default:
                break
            }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            backgroundColor = .white
        }
        
        let segmentControlView = UIView()
        segmentControlView.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(segmentControlView.snp.top)
            make.leading.equalTo(segmentControlView.snp.leading).offset(64)
            make.trailing.equalTo(segmentControlView.snp.trailing).offset(-64)
            make.bottom.equalTo(segmentControlView.snp.bottom)
        }
        
        stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                   segmentControlView,
                                                   signInorUpView])
        

        
        stackView.axis = .vertical
        stackView.spacing = 32.0
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(64)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
    }
    
    func createTextField(placeholder: String, isSecureTextField: Bool) -> UITextField{
        let textfield =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textfield.leftViewMode = .always
        textfield.leftView = spacerView
        textfield.placeholder = placeholder
        textfield.font = UIFont.systemFont(ofSize: 15)
        textfield.borderStyle = UITextField.BorderStyle.roundedRect
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = isSecureTextField
        textfield.backgroundColor = .red
        //sampleTextField.keyboardType = UIKeyboardType.default
        //sampleTextField.returnKeyType = UIReturnKeyType.done
        //sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        //sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textfield
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
