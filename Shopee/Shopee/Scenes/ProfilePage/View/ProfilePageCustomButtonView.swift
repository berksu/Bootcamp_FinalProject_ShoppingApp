//
//  ProfilePageCustomButtonView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 31.10.2022.
//

import UIKit

final class ProfileViewCustomButtonView: UIView{
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont(name: "Poppins-Bold", size: 18)
        label.textColor = .black
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textColor = UIColor(red: 144, green: 144, blue: 144)
        return label
    }()
    
    private let labelsStackView:UIStackView = {
        let stack = UIStackView()
        stack.spacing = 6
        stack.axis = .vertical
        return stack
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightArrow")
        imageView.tintColor = UIColor(rgb: 242424)
        imageView.snp.makeConstraints { make in
            make.height.equalTo(13.5)
            make.width.equalTo(7.5)
        }
        return imageView
    }()
    
    
    init(title:String, description: String){
        super.init(frame: .zero)
        backgroundColor = .white
        
        titleLabel.text = title
        descriptionLabel.text = description

        addShadow()
        
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)
        
        addSubview(labelsStackView)
        labelsStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(19)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).offset(-19)
            make.centerY.equalTo(self.snp.centerY)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileViewCustomButtonView{
    private func addShadow(){
        clipsToBounds = false
        layer.cornerRadius = 10
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
    }
}

