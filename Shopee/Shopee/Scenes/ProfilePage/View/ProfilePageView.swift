//
//  ProfilePageView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 31.10.2022.
//

import UIKit

final class ProfilePageView: UIView{
    
    private let userNameLabel = {
       let label = UILabel()
        label.text = "Username"
        label.font = UIFont(name: "Inter-Bold", size: 28)
        return label
    }()
    
    private let userEmailLabel = {
       let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "Inter-Regular", size: 14)
        label.textColor =  UIColor(rgb: 0x808080, a: 1)
        return label
    }()
    
    private let userNameAndEmailStack:UIStackView = {
        let stack = UIStackView()
        stack.spacing = 4
        stack.axis = .vertical
        return stack
    }()
    
    init(){
        super.init(frame: .zero)
        backgroundColor = .white
        
        userNameAndEmailStack.addArrangedSubview(userNameLabel)
        userNameAndEmailStack.addArrangedSubview(userEmailLabel)
        
        addSubview(userNameAndEmailStack)
        userNameAndEmailStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.height.equalTo(60)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


