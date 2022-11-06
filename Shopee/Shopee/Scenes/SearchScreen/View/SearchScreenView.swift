//
//  SearchScreenView.swift
//  Shopee
//
//  Created by Berksu Kısmet on 4.11.2022.
//

import UIKit

final class SearchScreenView: UIView{
    
    let productsInCartTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SearchScreenTableViewCustomCell.self, forCellReuseIdentifier: SearchScreenTableViewCustomCell.identifier)
        return tableView
    }()
    
    lazy var stackCategoryView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
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
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(30)
        }
        
        scrollView.addSubview(stackCategoryView)
        stackCategoryView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading).offset(16)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.height.equalTo(30)
        }
        
        addSubview(productsInCartTableView)
        productsInCartTableView.snp.makeConstraints { make in
            make.top.equalTo(stackCategoryView.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchScreenView{

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
