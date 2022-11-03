//
//  ScrollableLabel.swift
//  Shopee
//
//  Created by Berksu Kısmet on 1.11.2022.
//

import UIKit

final class ScrollableLabel: UIView{
    
    var text: String?{
        didSet{
            productDescriptionLabel.text = text
        }
    }
    
    private let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 144, green: 144, blue: 144)
        label.font = UIFont(name: "Poppins-Regular", size: 14)

        return label
    }()
    
    
    init(){
        super.init(frame: .zero)
        commonInit()
    }
    
    private lazy var scrollView: UIScrollView = {
      let sv = UIScrollView()
      return sv
    }()
    
    private lazy var contentView: UIView = {
      let view = UIView()
      return view
    }()

    
    private func commonInit() {
      setupScrollViewContstraints()
      setupContentViewConstraints()
      setupDescriptionLabelConstraints()
    }
    
    private func setupScrollViewContstraints() {
      addSubview(scrollView)
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        scrollView.topAnchor.constraint(equalTo: topAnchor),
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      ])
    }
    
    private func setupContentViewConstraints() {
      scrollView.addSubview(contentView)
      contentView.translatesAutoresizingMaskIntoConstraints = false
      let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
      heightConstraint.priority = UILayoutPriority(250)
      NSLayoutConstraint.activate([
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        heightConstraint,
      ])
    }
    
    private func setupDescriptionLabelConstraints() {
      contentView.addSubview(productDescriptionLabel)
        productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        productDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
        productDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        productDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        productDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
      ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


