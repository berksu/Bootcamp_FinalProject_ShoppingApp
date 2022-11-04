//
//  ProductScreenViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 30.10.2022.
//

import UIKit

final class ProductScreenViewController: UIViewController{
    
    let productView = ProductScreenView()
    let productViewModel = ProductScreenViewModel()

    var isOneAndOnlyTappedButton: Bool{
        let filter = productView.stackCategoryView.arrangedSubviews.filter { view in
            let button = view as! ScrollableStackButton
            return button.isTapped
        }
        
        return filter.count > 0 ? false:true
    }
    
    func setAllButtonsNotTapped(){
        productView.stackCategoryView.arrangedSubviews.forEach {view in
            let button = view as! ScrollableStackButton
            button.isTapped = false
            button.backgroundColor = .systemGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = productView
        
        productView.categories = productViewModel.categories
        
        LayoutConstraints.itemsInRow = (traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular) ? 3:2
        
        setCollectionViewDelegate()
        
        createNavigationBarButtons()
        navigationItem.titleView = createNavigationTitleLabel
        
        createStackCategoryViewButtons()

        productViewModel.changeHandler = {[weak self] change in
            switch change{
            case .didFetchProducts:
                print("Success")
                self?.productView.productCollectionView.reloadData()
            case .didErrorOccurred(let error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        productViewModel.fetchData()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func createStackCategoryViewButtons(){
        productView.stackCategoryView.arrangedSubviews.forEach { view in
            let button = view as! ScrollableStackButton
            button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        }
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
            productViewModel.searchProuct(category: chosenCategory.substring(with: 2..<chosenCategory.count-2))
        }else{
            productViewModel.fetchData()
            sender.isTapped = false
            sender.backgroundColor = .systemGray
        }
    }

    func createNavigationBarButtons(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "basketIcon"), style: .plain, target: self, action: #selector(basketButton))
        navigationItem.rightBarButtonItem?.tintColor = .systemGray
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "searchIcon"), style: .plain, target: self, action: #selector(searchButton))
//        navigationItem.leftBarButtonItem?.tintColor = .systemGray
    }
    
    private var createNavigationTitleLabel: UIStackView = {
        let topLabel = UILabel()
        topLabel.text = "Be"
        topLabel.font = UIFont(name: "Inter-Regular", size: 18)
        topLabel.textColor = .systemGray
        
        let bottomLabel = UILabel()
        bottomLabel.text = "Creative"
        bottomLabel.font = UIFont(name: "Inter-Bold", size: 24)
        bottomLabel.textColor = .systemGray
        
        let stackView = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4.0

        return stackView
    }()
    
    @objc func basketButton(_ sender: UIButton){
        let basketScreenViewController = BasketScreenViewController()
        basketScreenViewController.modalPresentationStyle = .formSheet
        self.navigationController?.present(basketScreenViewController, animated: true)
        //self.navigationController?.pushViewController(basketScreenViewController, animated: true)
        //productDetailsViewController.modalPresentationStyle = .fullScreen
        //self.navigationController?.present(productDetailsViewController, animated: true)
    }
}

extension ProductScreenViewController{
    //MARK: -set delegates
    func setCollectionViewDelegate() {
        productView.productCollectionView.delegate = self
        productView.productCollectionView.dataSource = self
    }
}

//MARK: -UICollectionViewController Delegate
extension ProductScreenViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index: \(indexPath.row)")
        // Create the view controller.
        let productAtIndex = productViewModel.getProductAtIndex(indexPath.row)
        
        let productDetailsViewController = ProductDetailsViewController()
        //productDetailsViewController.presentationController?.delegate = self
        productDetailsViewController.product = productAtIndex
        // Present it w/o any adjustments so it uses the default sheet presentation.
        productDetailsViewController.modalPresentationStyle = .fullScreen
        present(productDetailsViewController, animated: true, completion: nil)
        //self.navigationController?.pushViewController(productDetailsViewController, animated: true)
    }
}

//MARK: -UICollectionViewController DataSource
extension ProductScreenViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productViewModel.productCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductViewCell else{
            return UICollectionViewCell()
        }

        let product = productViewModel.getProductAtIndex(indexPath.row)
        cell.productName = product.title ?? ""
        cell.productPrice = product.price ?? 0.0

        let url = productViewModel.getImageURLAtIndex(indexPath.row)
        KingfisherOperations.shared.downloadImage(url: url, imageView: cell.productImage){result in
            switch result{
            case .imageDownloadedSuccessfully:
                collectionView.reloadItems(at: [indexPath])
            case .didErrorOccurred(let error):
                print(error)
            }
        }
        
        return cell
    }
}

extension ProductScreenViewController: UICollectionViewDelegateFlowLayout {
    
    struct LayoutConstraints{
        static var itemsInRow: CGFloat = 3
        static var widthHeightRatio = 1.2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = itemWidth(for: view.frame.width, spacing: 0)

        return CGSize(width: width, height: width * LayoutConstraints.widthHeightRatio)
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing: CGFloat = 2 * spacing + (LayoutConstraints.itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / LayoutConstraints.itemsInRow

        return finalWidth - (5.0 * (LayoutConstraints.itemsInRow - 1))
    }
}


