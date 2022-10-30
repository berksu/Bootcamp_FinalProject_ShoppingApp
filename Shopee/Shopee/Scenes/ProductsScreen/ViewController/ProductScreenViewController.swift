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

    private var navigationBarSearchControllerIsHidden: Bool = true {
        willSet{
            navigationItem.searchController?.searchBar.isHidden = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = productView
        
        LayoutConstraints.itemsInRow = (traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular) ? 3:2
        
        setCollectionViewDelegate()
        
        productViewModel.changeHandler = {[weak self] change in
            switch change{
            case .didFetchProducts:
                print("Success")
            case .didErrorOccurred(let error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        productViewModel.fetchData()
        
        navigationItem.titleView = createNavigationTitleLabel()
        createNavigationBarButtons()
        navigationItem.largeTitleDisplayMode = .never
    }
    

    func createNavigationBarButtons(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "basketIcon"), style: .plain, target: self, action: #selector(basketButton))
        navigationItem.rightBarButtonItem?.tintColor = .systemGray
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "searchIcon"), style: .plain, target: self, action: #selector(searchButton))
        navigationItem.leftBarButtonItem?.tintColor = .systemGray
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
        navigationBarSearchControllerIsHidden.toggle()
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
