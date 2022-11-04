//
//  SearchScreenViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 4.11.2022.
//

import UIKit

final class SearchScreenViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        createNavigationBarButtons()
        createSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .never
    }

    func createNavigationBarButtons(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "basketIcon"), style: .plain, target: self, action: #selector(basketButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemGray
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "searchIcon"), style: .plain, target: self, action: #selector(searchButton))
//        navigationItem.leftBarButtonItem?.tintColor = .systemGray
    }
    
    @objc func basketButtonTapped(sender: UIButton){
        
    }
    
    func createSearchBar(){
        // Add search controller on navigation item
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search For Fun ..."
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}

// MARK: - Search delegate
extension SearchScreenViewController: UISearchResultsUpdating{
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            print(text)
        }else{
            print("add more button")
        }
    }
}
