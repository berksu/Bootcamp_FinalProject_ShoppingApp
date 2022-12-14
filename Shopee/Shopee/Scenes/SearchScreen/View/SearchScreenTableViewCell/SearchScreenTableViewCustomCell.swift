//
//  SearchScreenTableViewCustomCell.swift
//  Shopee
//
//  Created by Berksu Kısmet on 4.11.2022.
//

import UIKit

final class SearchScreenTableViewCustomCell: UITableViewCell{
    
    static let identifier = "SearchScreenTableViewCustomCell"
    
    var productName: String?{
        didSet{
            productNameLabel.text = productName
        }
    }
    
    var productPrice: Double?{
        didSet{
            guard let productPrice = productPrice else{return}
            productPriceLabel.text = "$ \(productPrice)"
        }
    }
    
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
        label.text = "Label"
        label.textColor = .black
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.font = UIFont(name: "Poppins-Regular", size: 18)
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 50"
        label.textColor = .black
        label.font = UIFont(name: "Poppins-Bold", size: 20)
        return label
    }()
    
    private let labelsStackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        setProductImageView()
        setLabelsStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchScreenTableViewCustomCell{
    private func setProductImageView(){
        addSubview(shadowView)

        shadowView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(16)
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


extension SearchScreenTableViewCustomCell{
    private func setLabelsStackView(){
        labelsStackView.addArrangedSubview(productNameLabel)
        labelsStackView.addArrangedSubview(productPriceLabel)

        addSubview(labelsStackView)

        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(shadowView.snp.top)
            make.leading.equalTo(shadowView.snp.trailing).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
    }
}
