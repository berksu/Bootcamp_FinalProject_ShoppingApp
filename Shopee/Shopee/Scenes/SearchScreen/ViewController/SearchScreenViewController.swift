//
//  SearchScreenViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 4.11.2022.
//

import UIKit

final class SearchScreenViewController: UIViewController{
    
    private let searchScreeView = SearchScreenView()
    private let searchScreenViewModel = SearchScreenViewModel()
    
    
    var isOneAndOnlyTappedButton: Bool{
        let filter = searchScreeView.stackCategoryView.arrangedSubviews.filter { view in
            let button = view as! ScrollableStackButton
            return button.isTapped
        }
        
        return filter.count > 0 ? false:true
    }
    
    func setAllButtonsNotTapped(){
        searchScreeView.stackCategoryView.arrangedSubviews.forEach {view in
            let button = view as! ScrollableStackButton
            button.isTapped = false
            button.backgroundColor = .systemGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchScreeView
        searchScreeView.categories = searchScreenViewModel.categories
        
        initTableView()
        
        createNavigationBarButtons()
        createSearchBar()
        createStackCategoryViewButtons()
        
        searchScreenViewModel.changeHandler = {[weak self] change in
            switch change{
            case .didFetchProducts:
                self?.searchScreeView.productsInCartTableView.reloadData()
            case .didFetchCategories:
                self?.searchScreeView.categories = self?.searchScreenViewModel.categories
                self?.createStackCategoryViewButtons()
            case .didErrorOccurred(let error):
                print(error)
            }
        }
        
        searchScreenViewModel.basketChangeHandler = {[weak self] change in
            switch change{
            case .didBasketEmpty(let isEmpty):
                self?.navigationItem.rightBarButtonItem?.tintColor = isEmpty ? .systemGray: .green
            case .didErrorOccurred(let error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .never
        searchScreenViewModel.fetchBasket()
    }
    
    @objc func categoryButtonTapped(sender: ScrollableStackButton){
        guard let chosenCategory = sender.titleLabel?.text else {return}
        if !sender.isTapped{
            if isOneAndOnlyTappedButton{
                sender.isTapped = true
            }else{
                setAllButtonsNotTapped()
                sender.isTapped = true
            }
            sender.backgroundColor = .orange
            searchScreenViewModel.searchCategory(category: chosenCategory.substring(with: 2..<chosenCategory.count-2))
        }else{
            searchScreenViewModel.fetchData()
            searchScreenViewModel.removeCategoryFilter()
            sender.isTapped = false
            sender.backgroundColor = .systemGray
        }
    }

    func createStackCategoryViewButtons(){
        searchScreeView.stackCategoryView.arrangedSubviews.forEach { view in
            let button = view as! ScrollableStackButton
            button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        }
    }
    
    // MARK: -TableView init
    func initTableView(){
        searchScreeView.productsInCartTableView.dataSource = self
        searchScreeView.productsInCartTableView.delegate = self
    }
    
    private func createNavigationBarButtons(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "basketIcon"), style: .plain, target: self, action: #selector(basketButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemGray
    }
    
    @objc func basketButtonTapped(_ sender: UIButton){
        let basketScreenViewController = BasketScreenViewController()
        basketScreenViewController.modalPresentationStyle = .formSheet
        self.navigationController?.present(basketScreenViewController, animated: true)
    }
    
    private func createSearchBar(){
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search Product ..."
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}

// MARK: - Search delegate
extension SearchScreenViewController: UISearchResultsUpdating{
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 2 {
            searchScreenViewModel.searchProuct(word: text)
        }else{
            searchScreenViewModel.showOnlyCategoryResultIfThereIsOne()
        }
    }
}


// MARK: - TableView Delegate
extension SearchScreenViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create the view controller.
        let productAtIndex = searchScreenViewModel.products[indexPath.row]
        
        let productDetailsViewController = ProductDetailsViewController()
        productDetailsViewController.product = productAtIndex
        productDetailsViewController.modalPresentationStyle = .fullScreen
        present(productDetailsViewController, animated: true, completion: nil)
    }
}

// MARK: - TableView DataSource
extension SearchScreenViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchScreenViewModel.products.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchScreenTableViewCustomCell.identifier, for: indexPath) as? SearchScreenTableViewCustomCell else{
            return UITableViewCell()
        }

        let product = searchScreenViewModel.products[indexPath.row]

        cell.productName = product.title
        cell.productPrice = product.price
        
        searchScreenViewModel.downloadProductImage(url: product.image ?? "", imageView: cell.productImageView)
        return cell
    }
}
