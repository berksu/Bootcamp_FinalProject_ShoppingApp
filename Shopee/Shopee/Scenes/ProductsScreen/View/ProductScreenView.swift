//
//  ProductScreenView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 30.10.2022.
//

import UIKit

final class ProductScreenView: UIView{
    
//    // MARK: - Properties
//    private let cellInset: CGFloat = 5.0
//    private var cellMultiplier: CGFloat = 0.5
////    var cellDimension: CGFloat {
////        .screenWidth * cellMultiplier - cellInset
////    }
//    var cellDimension: CGFloat = 0.0
//
//
//    private lazy var flowLayout: UICollectionViewFlowLayout = {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSize(width: cellDimension, height: cellDimension * 1.3)
//        return flowLayout
//    }()
    
    lazy var productCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    init(){
        super.init(frame: .zero)
        backgroundColor = .white
        productCollectionView.register(ProductViewCell.self , forCellWithReuseIdentifier: "cell")
        addSubview(productCollectionView)
        productCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

