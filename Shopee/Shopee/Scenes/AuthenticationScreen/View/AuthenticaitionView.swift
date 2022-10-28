//
//  AuthenticaitionView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 26.10.2022.
//

import UIKit

final class AuthenticationView: UIView{
    
    var indicatorHidden: Bool = true{
        didSet{
            indicatorView.isHidden = indicatorHidden
            stackView.alpha = indicatorHidden ? 1.0:0.5
            signInSingUpButton.alpha = indicatorHidden ? 1.0:0.5
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.tintColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private var stackView = UIStackView()
    private var outerStackView = UIStackView()

    var signInView = SignInView()
    var signUpView = SignUpView()

    private var signInorUpView: UIView{
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
    
    
    private var segmentControlView:UIView{
        let view = UIView()
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading).offset(64)
            make.trailing.equalTo(view.snp.trailing).offset(-64)
            make.bottom.equalTo(view.snp.bottom)
        }
        return view
    }
    
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
            switch (segmentedControl.selectedSegmentIndex) {
            case 0:
                titleLabel.text = "Sign In"
                signInSingUpButton.setTitle("Sign In", for: .normal)
                signInSingUpButton.tag = 0
                signInorUpView = signInView
            case 1:
                titleLabel.text = "Sign Up"
                signInSingUpButton.setTitle("Sign Up", for: .normal)
                signInSingUpButton.tag = 1
                signInorUpView = signUpView
            default:
                break
            }
    }
    
    private(set) var signInSingUpButton: UIButton = {
        var button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.tag = 0
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
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
        signInorUpView = signInView
        
        super.init(frame: frame)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            backgroundColor = .white
        }

        stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                   segmentControlView,
                                                   signInorUpView])
        
        stackView.axis = .vertical
        stackView.spacing = 32.0
        
        outerStackView = UIStackView(arrangedSubviews: [topMenuIconStack, stackView])
        outerStackView.axis = .vertical
        outerStackView.spacing = 100
        
        
        addSubview(outerStackView)
        outerStackView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(64)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
        
        addSubview(signInSingUpButton)
        signInSingUpButton.snp.makeConstraints { make in
            make.top.equalTo(outerStackView.snp.bottom).offset(32)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.height.equalTo(35)
        }
        
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
    }
    
    func createTextField(placeholder: String, isSecureTextField: Bool) -> UITextField{
        let textfield =  UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
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

extension AuthenticationView{
    
    private var topMenuIconStack: UIView{
        
        let testFrame = CGRect(x: 0, y: 100, width: 100, height: 400)
        let view = UIView(frame: testFrame)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "splashScreenLogo")
        imageView.contentMode = .scaleAspectFit

        let lineViewLeading = UIView()
        lineViewLeading.layer.borderWidth = 1.0
        lineViewLeading.layer.borderColor = UIColor.black.cgColor

        let lineViewTrailing = UIView()
        lineViewTrailing.layer.borderWidth = 1.0
        lineViewTrailing.layer.borderColor = UIColor.black.cgColor

        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top)
            make.width.equalTo(75)
            make.height.equalTo(75)
        }

        view.addSubview(lineViewLeading)
        lineViewLeading.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.width.equalTo(UIScreen.main.bounds.width * 0.3)
            make.height.equalTo(1)
            make.centerY.equalTo(imageView.snp.centerY)
        }

        view.addSubview(lineViewTrailing)
        lineViewTrailing.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing)
            make.width.equalTo(UIScreen.main.bounds.width * 0.3)
            make.height.equalTo(1)
            make.centerY.equalTo(imageView.snp.centerY)
        }
        return view
    }
}
