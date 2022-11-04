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
    
    var totalPrice: Double?{
        didSet{
            guard let totalPrice = totalPrice else{return}
            totalPriceAmountLabel.text = "$ \(totalPrice)"
        }
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
    
    let checkOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.tintColor = .white
        button.setTitle("Check Out", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 20)!
        button.layer.cornerRadius = 10
        button.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(CGFloat.screenWidth * 0.8)
        }
        return button
    }()
    
    private let totalPriceTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Total:"
        label.font = UIFont(name: "Inter-Bold", size: 20)
        label.textColor = UIColor(red: 128, green: 128, blue: 128)
        label.sizeToFit()
        label.snp.makeConstraints { make in
            make.height.equalTo(28)
        }
        return label
    }()
    
    private let totalPriceAmountLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .right
        label.text = "$ 10"
        label.textColor = UIColor(red: 48, green: 48, blue: 48)
        label.font = UIFont(name: "Inter-Bold", size: 20)
        label.sizeToFit()
        label.snp.makeConstraints { make in
            make.height.equalTo(28)
        }
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        backgroundColor = .white
        
//        addSubview(backButton)
//        backButton.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32)
//            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
//        }
//
        addSubview(pageTitleLabel)
        pageTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32)
            //make.top.equalTo(backButton.snp.top)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        addSubview(productsInCartTableView)
        productsInCartTableView.snp.makeConstraints { make in
            make.top.equalTo(pageTitleLabel.snp.bottom).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
        }

        addSubview(totalPriceTitleLabel)
        totalPriceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(productsInCartTableView.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(CGFloat.screenWidth * 0.1)
        }
        
        addSubview(totalPriceAmountLabel)
        totalPriceAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(totalPriceTitleLabel.snp.top)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-CGFloat.screenWidth * 0.1)
        }
        
        addSubview(checkOutButton)
        checkOutButton.snp.makeConstraints { make in
            make.top.equalTo(totalPriceTitleLabel.snp.bottom).offset(16)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

