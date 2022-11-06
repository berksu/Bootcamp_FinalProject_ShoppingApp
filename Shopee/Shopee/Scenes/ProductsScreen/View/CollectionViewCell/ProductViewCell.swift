//
//  ProductViewCell.swift
//  Shopee
//
//  Created by Berksu Kısmet on 30.10.2022.
//

import UIKit

final class ProductViewCell: UICollectionViewCell{
    
    var productName: String?{
        willSet{
            guard let value = newValue else {return}
            productNameLabel.text = value
        }
    }
    
    var productPrice: Double?{
        willSet{
            guard let value = newValue else {return}
            productPriceLabel.text = "$ \(value)"
        }
    }
    
    var productImage: UIImageView{
        get{
            photoImageView
        }
    }
    
    private let photoImageView: UIImageView = UIImageView()
    
    private func shadowView(dimension: CGFloat) -> UIView {
        let outerView = UIView()
        outerView.snp.makeConstraints { make in
            make.width.equalTo(dimension)
            make.height.equalTo(dimension)
        }
        outerView.clipsToBounds = false
        outerView.layer.cornerRadius = 10
        outerView.backgroundColor = .white
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 10
        return outerView
    }
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textColor = .systemGray
        label.numberOfLines = 2
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 14)
        label.textColor = .black
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let size = contentView.bounds.width * 0.8
        let outerView = shadowView(dimension: size)
        
        photoImageView.frame = outerView.bounds
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 10
      
        outerView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.centerX.equalTo(outerView.snp.centerX)
            make.centerY.equalTo(outerView.snp.centerY)
            make.width.equalTo(outerView.snp.width).multipliedBy(0.75)
            make.height.equalTo(outerView.snp.height).multipliedBy(0.75)
        }
        
        let stackView = UIStackView(arrangedSubviews: [outerView,
                                                       productNameLabel,
                                                       productPriceLabel])
        stackView.axis = .vertical
        stackView.spacing = 6.0
        stackView.setCustomSpacing(2.0, after: productNameLabel)
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(30)
            make.centerX.equalTo(self.snp.centerX)
        }        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension UIImageView {
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
