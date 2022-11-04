//
//  ProductScreenView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 30.10.2022.
//

import UIKit

final class ProductScreenView: UIView{
    
    lazy var productCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    
    lazy var stackCategoryView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    // 2.
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(stackCategoryView)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    var categories:[String]!{
        didSet{
            stackCategoryView.removeAllArrangedSubviews()
            
            for category in categories {
                let categoryButton = createCategoryButton(title: "  \(category)  ")
                stackCategoryView.addArrangedSubview(categoryButton)
            }
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .white
        
        productCollectionView.register(ProductViewCell.self , forCellWithReuseIdentifier: "cell")
    
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            //make.edges.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(30)
        }
        
        scrollView.addSubview(stackCategoryView)
        stackCategoryView.snp.makeConstraints { (make) in
            //make.edges.equalToSuperview()
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading).offset(16)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.height.equalTo(30)
        }
        
        addSubview(productCollectionView)
        productCollectionView.snp.makeConstraints { make in
            make.top.equalTo(stackCategoryView.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductScreenView{

    func createCategoryButton(title: String) -> ScrollableStackButton{
        let button = ScrollableStackButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 6
        button.sizeToFit()
        button.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        return button
    }
}
