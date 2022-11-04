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
    
    var products: [Product] = []{
        didSet{
            searchScreeView.productsInCartTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchScreeView
        
        initTableView()
        
        createNavigationBarButtons()
        createSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .never
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
    
    @objc func basketButtonTapped(sender: UIButton){
        
    }
    
    private func createSearchBar(){
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
        if let text = searchController.searchBar.text, text.count > 2 {
            products = searchScreenViewModel.searchProuct(word: text)
        }else{
            products = []
        }
    }
}


// MARK: - TableView Delegate
extension SearchScreenViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index: \(indexPath.row)")
        // Create the view controller.
        let productAtIndex = products[indexPath.row]
        
        let productDetailsViewController = ProductDetailsViewController()
        productDetailsViewController.product = productAtIndex
        // Present it w/o any adjustments so it uses the default sheet presentation.
        productDetailsViewController.modalPresentationStyle = .fullScreen
        present(productDetailsViewController, animated: true, completion: nil)
    }
}

// MARK: - TableView DataSource
extension SearchScreenViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchScreenTableViewCustomCell.identifier, for: indexPath) as? SearchScreenTableViewCustomCell else{
            return UITableViewCell()
        }

        let product = products[indexPath.row]

        cell.productName = product.title
        cell.productPrice = product.price
        
        searchScreenViewModel.downloadProductImage(url: product.image ?? "", imageView: cell.productImageView)
        return cell
    }
}
