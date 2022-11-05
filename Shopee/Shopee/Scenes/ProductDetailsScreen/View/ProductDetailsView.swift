//
//  ProductDetailsView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 1.11.2022.
//

import UIKit

final class ProductDetailView: UIView{
    
    enum AddToCartButtonStyle{
        case addToCart
        case removeFromCart
        case updateCart
    }
    
    var title: String?{
        didSet{
            productNameLabel.text = title
        }
    }
    
    var descriptionText: String?{
        didSet{
            productDescriptionLabel.text = descriptionText
        }
    }
    
    var price: Double?{
        didSet{
            guard let price = price else{return}
            productPriceLabel.text = "$ \(price)"
        }
    }
    
    var rate: Double?{
        didSet{
            guard let rate = rate else{return}
            productRatingLabel.text = "\(rate)"
        }
    }
    
    var commentCount: Int?{
        didSet{
            guard let commentCount = commentCount else{return}
            productRatingCountLabel.text = "(\(commentCount) comments)"
        }
    }
    
    var productCount: Int?{
        get{
            guard let text = stepperLabel.text else{return nil}
            return Int(text)
        }
        set{
            guard let text = newValue else{return}
            stepperLabel.text = "\(text)"
        }
    }
    
    var isAddToCartButton: AddToCartButtonStyle = .addToCart{
        didSet{
            switch isAddToCartButton{
            case .addToCart:
                addToCartButton.setTitle("Add to cart", for: .normal)
                addToCartButton.backgroundColor = .black
            case .removeFromCart:
                addToCartButton.setTitle("Remove from cart", for: .normal)
                addToCartButton.backgroundColor = .red
            case .updateCart:
                addToCartButton.setTitle("Update cart", for: .normal)
                addToCartButton.backgroundColor = .black
            }
        }
    }

    var backButton: UIButton = {
       var button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        return button
    }()
    
    private let shadowView: UIView = {
        let outerView = UIView()
        outerView.clipsToBounds = false
        outerView.layer.cornerRadius = 10
        outerView.backgroundColor = .white
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 10
        return outerView
    }()
    
    let productImageView = UIImageView()

    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .black
        label.tintColor = UIColor(red: 144, green: 144, blue: 144, alpha: 1)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.sizeToFit()
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 50"
        label.textColor = .black
        label.tintColor = .black
        label.font = UIFont(name: "Poppins-Bold", size: 16)
        label.sizeToFit()
        return label
    }()
    
    private let stepperLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.tintColor = .black
        label.font = UIFont(name: "Inter-Regular", size: 18)
        label.sizeToFit()
        return label
    }()
    
    private let horizontalButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 14
        stack.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        return stack
    }()
    
    private let horizontalPriceAndButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        stack.spacing = 8
        return stack
    }()
    
    private let starIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        return imageView
    }()
    
    private let productRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.5"
        label.textColor = .black
        label.tintColor = .black
        label.font = UIFont(name: "Poppins-Bold", size: 18)
        label.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        label.sizeToFit()
        return label
    }()
    
    private let productRatingCountLabel: UILabel = {
        let label = UILabel()
        label.text = "(50 comments)"
        label.textColor = UIColor(red: 144, green: 144, blue: 144)
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.sizeToFit()
        return label
    }()
    
    private let horizontalRatingStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 16
        stack.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return stack
    }()
    

    let addToCartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.tintColor = .white
        button.setTitle("Add to cart", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 20)!
        button.layer.cornerRadius = 10
        button.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(CGFloat.screenWidth * 0.8)
        }
        return button
    }()
    
    private let verticalInformationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()
    
    private let productDescriptionLabel = ScrollableLabel()
    
    var plusButton: UIButton = UIButton()
    var minusButton: UIButton = UIButton()

    init(){
        super.init(frame: .zero)
        backgroundColor = .white
 
        plusButton = createStepperButton(image: "plus")
        minusButton = createStepperButton(image: "minus")
        
        productDescriptionLabel.text = "Placeholder"
        
        setBackButton()
        setProductImageView()
        setInformationLabels()
        setDescriptionAndButton()

    }
    
    func setBackButton(){
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(self.snp.leading).offset(16)
        }
    }
    
    func setProductImageView(){
        addSubview(shadowView)

        shadowView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(12)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.height.equalTo(self.snp.width).multipliedBy(0.7)
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
    
    func setInformationLabels(){
        horizontalRatingStack.addArrangedSubview(starIcon)
        horizontalRatingStack.addArrangedSubview(productRatingLabel)
        horizontalRatingStack.addArrangedSubview(productRatingCountLabel)
        horizontalRatingStack.setCustomSpacing(4, after: starIcon)
        
        horizontalButtonStack.addArrangedSubview(minusButton)
        horizontalButtonStack.addArrangedSubview(stepperLabel)
        horizontalButtonStack.addArrangedSubview(plusButton)
        
        horizontalPriceAndButtonStack.addArrangedSubview(productPriceLabel)
        horizontalPriceAndButtonStack.addArrangedSubview(horizontalButtonStack)

        verticalInformationStack.addArrangedSubview(productNameLabel)
        verticalInformationStack.addArrangedSubview(horizontalPriceAndButtonStack)
        verticalInformationStack.addArrangedSubview(horizontalRatingStack)

        addSubview(verticalInformationStack)
        verticalInformationStack.snp.makeConstraints { make in
            make.top.equalTo(shadowView.snp.bottom).offset(25)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
    }
    
    func setDescriptionAndButton(){
        addSubview(productDescriptionLabel)
        productDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(verticalInformationStack.snp.bottom).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
        
        addSubview(addToCartButton)
        addToCartButton.snp.makeConstraints { make in
            make.top.equalTo(productDescriptionLabel.snp.bottom).offset(25)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-25)

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ProductDetailView{
    func createStepperButton(image: String) -> UIButton{
        let button = UIButton()
        button.setImage(UIImage(named: image), for: .normal)
        button.backgroundColor = UIColor(red: 144, green: 144, blue: 144).withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        return button
    }
}
