//
//  BasketScreenView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 3.11.2022.
//

import UIKit

final class BasketScreenView: UIView{
    
    var backButtonController: UIButton{
        return backButton
    }
    
    private var backButton: UIButton = {
       var button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        return button
    }()

    override init(frame: CGRect){
        super.init(frame: .zero)
        backgroundColor = .blue
        
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



