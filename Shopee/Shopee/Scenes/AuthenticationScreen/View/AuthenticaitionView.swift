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
        return label
    }()
    
    // MARK: - Define Segment Control
    let segmentedControl: UISegmentedControl = {
        let items = ["Sign In", "Sign Up"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 1
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
                print("sign in")
            case 1:
                print("sign up")
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
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
        
        addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.width.equalTo(250)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
