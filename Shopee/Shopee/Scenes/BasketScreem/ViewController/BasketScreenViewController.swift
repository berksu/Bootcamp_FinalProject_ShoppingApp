//
//  BasketScreenViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 3.11.2022.
//

import UIKit

final class BasketScreenViewController: UIViewController, AlertPresentable{
    private let basketScreenView = BasketScreenView()
    private let basketScreenViewModel = BasketScreenViewModel()

    var productsThatInCart: [CartProduct] = []
    
    var totalPriceOfBasket: Double{
        var total = 0.0
        productsThatInCart.forEach { element in
            guard let productPrice = element.product?.price else{return}
            guard let productCount = element.count else{return}

            total += productPrice * Double(productCount)
        }
        basketScreenView.totalPrice = total
        return total
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view = basketScreenView
        
        initTableView()
        basketScreenView.backButtonController.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        basketScreenView.checkOutButton.addTarget(self, action: #selector(checkOutButtonTapped), for: .touchUpInside)
        
        basketScreenViewModel.changeHandler = {[weak self] change in
            switch change{
            case .didProductThatInCartFetchedSuccessfully(let cartProducts):
                self?.productsThatInCart = cartProducts
                self?.basketScreenView.productsInCartTableView.reloadData()
            case .didErrorOccurred(let error):
                self?.showError(error)
            default:
                break
            }
        }
    }

    override func viewWillAppear(_ animated: Bool){
        basketScreenViewModel.fetchAllProductsThatInBasket()
    }
    
    @objc func backButtonTapped(sender: UIButton){
        basketScreenViewModel.updateProductsInBasket(productsThatInCart)
        dismiss(animated: true)
    }
    
    @objc func checkOutButtonTapped(sender: UIButton){
        
    }
    
    // MARK: -TableView init
    func initTableView(){
        basketScreenView.productsInCartTableView.dataSource = self
        basketScreenView.productsInCartTableView.delegate = self
    }
}

// MARK: - TableView Delegate
extension BasketScreenViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index: \(indexPath.row)")
    }
}

// MARK: - TableView DataSource
extension BasketScreenViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productsThatInCart.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCustomCell.identifier, for: indexPath) as? BasketTableViewCustomCell else{
            return UITableViewCell()
        }

        let cartProduct = productsThatInCart[indexPath.row]
        guard let product = cartProduct.product else{return cell}
        guard let productCountInBasket = cartProduct.count else{return cell}

        cell.productName = product.title
        cell.productPrice = product.price
        cell.productCountInCart = productCountInBasket
        
        basketScreenViewModel.downloadProductImage(url: product.image ?? "", imageView: cell.productImageView)
        cell.minusButton.cell = cell
        cell.minusButton.index = indexPath.row

        cell.plusButton.cell = cell
        cell.plusButton.index = indexPath.row

        cell.removeFromCartButton.cell = cell
        cell.removeFromCartButton.index = indexPath.row
        
        cell.minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        cell.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        cell.removeFromCartButton.addTarget(self, action: #selector(removeFromCartButtonTapped), for: .touchUpInside)

        return cell
    }
    
    @objc func minusButtonTapped(sender: BasketButton){
        guard let productCount = sender.cell?.productCountInCart else{return}
        guard let index = sender.index else{return}

        sender.showAnimation {[weak self]  in
            if productCount > 1 {
                sender.cell?.productCountInCart = productCount - 1
                self?.productsThatInCart[index].count = productCount - 1
            }else if productCount == 1{
                self?.removeProduct(index: index)
            }
        }
    }
    
    @objc func plusButtonTapped(sender: BasketButton){
        guard let index = sender.index else{return}

        sender.showAnimation {[weak self] in
            // TODO: If there will be an upper limit, controls should be written in here
            guard let productCount = sender.cell?.productCountInCart else{return}
            sender.cell?.productCountInCart = productCount + 1
            self?.productsThatInCart[index].count = productCount + 1
        }
    }
    
    @objc func removeFromCartButtonTapped(sender: BasketButton){
        guard let index = sender.index else{return}
        sender.showAnimation {[weak self] in
            self?.removeProduct(index: index)
        }
    }
    
    func removeProduct(index: Int){
        showAlert(title: "Warning", message: "Do you really want to remove this product", cancelButtonTitle: "Cancel"){[weak self]_ in
            guard let cartProduct = self?.productsThatInCart[index] else{return}
            guard let product = cartProduct.product else{return}
            self?.basketScreenViewModel.removeChosenProductFromCart(productID: product.id)
            self?.productsThatInCart.remove(at: index)
            self?.basketScreenView.productsInCartTableView.reloadData()
        }
    }
}
