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
    
    private let pageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Cart"
        label.tintColor = .black
        label.font = UIFont(name: "Poppins-Bold", size: 16)
        label.sizeToFit()
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return label
    }()
    
    let productsInCartTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(BasketTableViewCustomCell.self, forCellReuseIdentifier: BasketTableViewCustomCell.identifier)
        return tableView
    }()

    override init(frame: CGRect){
        super.init(frame: .zero)
        backgroundColor = .white
        
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
        }
        
        addSubview(pageTitleLabel)
        pageTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.top)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        addSubview(productsInCartTableView)
        productsInCartTableView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



