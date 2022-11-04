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
        tableView.backgroundColor = .red
        tableView.register(SearchScreenTableViewCustomCell.self, forCellReuseIdentifier: SearchScreenTableViewCustomCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        addSubview(productsInCartTableView)
        productsInCartTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
