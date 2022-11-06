//
//  BasketTableViewCustomCell.swift
//  Shopee
//
//  Created by Berksu Kısmet on 3.11.2022.
//

import UIKit

final class BasketTableViewCustomCell: UITableViewCell{
    
    static let identifier = "BasketTableViewCustomCell"

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
    
    var productCountInCart: Int?{
        didSet{
            guard let productCountInCart = productCountInCart else{return}
            stepperLabel.text = "\(productCountInCart)"
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
        label.text = "Test"
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.snp.makeConstraints { make in
            make.width.equalTo(150)
        }
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 50"
        label.textColor = .black
        label.snp.makeConstraints { make in
            make.width.equalTo(150)
        }
        label.tintColor = .black
        label.font = UIFont(name: "Poppins-Bold", size: 16)
        return label
    }()
    
    private let labelsStackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }()
    
    private let horizontalStepperButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16
        stack.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        return stack
    }()
    var plusButton: BasketButton = BasketButton()
    var minusButton: BasketButton = BasketButton()
    private let stepperLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.tintColor = .black
        label.font = UIFont(name: "Inter-Regular", size: 18)
        label.sizeToFit()
        return label
    }()
    
    let removeFromCartButton: BasketButton = {
        let button = BasketButton()
        button.setImage(UIImage(named: "removeFromCartIcon"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        plusButton = createStepperButton(image: "plus")
        minusButton = createStepperButton(image: "minus")
        
        setProductImageView()
        setLabelsStackView()
        setStepperButtonsStack()
        setRemoveFromCartButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension BasketTableViewCustomCell{
    private func setProductImageView(){
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


extension BasketTableViewCustomCell{
    private func setLabelsStackView(){
        labelsStackView.addArrangedSubview(productNameLabel)
        labelsStackView.addArrangedSubview(productPriceLabel)

        addSubview(labelsStackView)

        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(shadowView.snp.top)
            make.leading.equalTo(shadowView.snp.trailing).offset(20)
        }
    }
}


extension BasketTableViewCustomCell{
    private func createStepperButton(image: String) -> BasketButton{
        let button = BasketButton()
        button.setImage(UIImage(named: image), for: .normal)
        button.backgroundColor = UIColor(red: 144, green: 144, blue: 144).withAlphaComponent(0.2)
        button.layer.cornerRadius = 5
        button.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        return button
    }
    
    private func setStepperButtonsStack(){
        horizontalStepperButtonStack.addArrangedSubview(minusButton)
        horizontalStepperButtonStack.addArrangedSubview(stepperLabel)
        horizontalStepperButtonStack.addArrangedSubview(plusButton)
        
        addSubview(horizontalStepperButtonStack)
        horizontalStepperButtonStack.snp.makeConstraints { make in
            make.bottom.equalTo(shadowView.snp.bottom)
            make.leading.equalTo(shadowView.snp.trailing).offset(20)
        }
    }
}

extension BasketTableViewCustomCell{
    private func setRemoveFromCartButton(){
        addSubview(removeFromCartButton)
        removeFromCartButton.snp.makeConstraints { make in
            make.top.equalTo(labelsStackView.snp.top)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
    }
}
