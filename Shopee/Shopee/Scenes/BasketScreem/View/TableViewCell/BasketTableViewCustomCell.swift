//
//  BasketTableViewCustomCell.swift
//  Shopee
//
//  Created by Berksu Kısmet on 3.11.2022.
//

import UIKit

final class BasketTableViewCustomCell: UITableViewCell{
    
    static let identifier = "BasketTableViewCustomCell"

    private let shadowView: UIView = {
        let outerView = UIView()
        outerView.clipsToBounds = false
        outerView.layer.cornerRadius = 10
        outerView.backgroundColor = .white
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.3
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 10
        return outerView
    }()
    let productImageView = UIImageView()
    
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.tintColor = .black
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Poppins-Regular", size: 20)
        label.sizeToFit()
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 50"
        label.tintColor = .black
        label.font = UIFont(name: "Poppins-Bold", size: 26)
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setProductImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension BasketTableViewCustomCell{
    func setProductImageView(){
        addSubview(shadowView)

        shadowView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(16)
            //make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.top.equalTo(self.snp.top).offset(20)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
        productImageView.image = UIImage(named: "productPlaceholder")
        productImageView.frame = shadowView.bounds
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 10
      
        shadowView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.centerX.equalTo(shadowView.snp.centerX)
            make.centerY.equalTo(shadowView.snp.centerY)
            make.width.equalTo(shadowView.snp.width).multipliedBy(0.75)
            make.height.equalTo(shadowView.snp.height).multipliedBy(0.75)
        }
    }
}
