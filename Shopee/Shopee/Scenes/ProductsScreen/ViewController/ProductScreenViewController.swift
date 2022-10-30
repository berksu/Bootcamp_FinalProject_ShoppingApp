//
//  ProductScreenViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 30.10.2022.
//

import UIKit

final class ProductScreenViewController: UIViewController{
    
    private var navigationBarSearchControllerIsHidden: Bool = true {
        willSet{
            navigationItem.searchController?.searchBar.isHidden = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "basketIcon"), style: .plain, target: self, action: #selector(basketButton))
        navigationItem.rightBarButtonItem?.tintColor = .systemGray
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "searchIcon"), style: .plain, target: self, action: #selector(searchButton))
        navigationItem.leftBarButtonItem?.tintColor = .systemGray
        
        navigationItem.largeTitleDisplayMode = .never
        
        // Add search controller on navigation item
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search For Fun ..."
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationBarSearchControllerIsHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView = createNavigationTitleLabel()
    }
    
    func createNavigationTitleLabel() -> UIStackView{
        let topLabel = UILabel()
        topLabel.text = "Design"
        topLabel.font = UIFont(name: "Inter-Bold", size: 18)
        topLabel.textColor = .systemGray
        
        let bottomLabel = UILabel()
        bottomLabel.text = "Your Life"
        bottomLabel.font = UIFont(name: "Inter-Regular", size: 14)
        bottomLabel.textColor = .systemGray
        
        let stackView = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4.0

        return stackView
    }
    
    @objc func basketButton(_ sender: UIButton){
        print("Basket opened")
    }
    
    @objc func searchButton(_ sender: UIButton){
        print("search opened")
        navigationBarSearchControllerIsHidden.toggle()
    }
}

// MARK: - Search delegate
extension ProductScreenViewController: UISearchResultsUpdating{
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            //searchViewModel.fetchSearchedPhotos(text: text)
        }else{
            //searchViewModel.fetchRecentPhotos()
        }
    }
}
