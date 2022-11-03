//
//  BasketScreenViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 3.11.2022.
//

import UIKit

final class BasketScreenViewController: UIViewController{
    private let basketScreenView = BasketScreenView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view = basketScreenView
        
        initTableView()
        
        basketScreenView.backButtonController.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped(sender: UIButton){
        dismiss(animated: true)
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
        3
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCustomCell.identifier, for: indexPath) as? BasketTableViewCustomCell else{
            return UITableViewCell()
        }
//
//        guard let photoAtIndex = mainViewModel.photoForIndexPath(indexPath) else {fatalError("Photo is nil")}
//
//
//        controlWhetherPhotoIsChosenOrNot(photoAtIndex: photoAtIndex, cell: cell)
//
//
//        let url = photoAtIndex.url_n ?? ""
//        if let farm = photoAtIndex.farm,
//           let server = photoAtIndex.server,
//           let owner = photoAtIndex.owner
//        {
//            let profileImageURL = "https://farm\(farm).staticflickr.com/\(server)/buddyicons/\(owner).jpg"
//
//            KingfisherOperations.shared.downloadProfileImage(url: profileImageURL, imageView: cell.profileImageView){success in
//                if(success){
//                    tableView.reloadRows(at: [indexPath], with: .automatic)
//                }
//            }
//
//        }
//
//
//        KingfisherOperations.shared.downloadImage(url: url, imageView: cell.photoImageView){success in
//            if success{
//                tableView.reloadRows(at: [indexPath], with: .automatic)
//            }
//        }
//        cell.title = photoAtIndex.ownername
//        cell.addFavouriteButton.photo = photoAtIndex
//        cell.addFavouriteButton.cell = cell
//        cell.addFavouriteButton.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
//
//        cell.saveButton.photo = photoAtIndex
//        cell.saveButton.cell = cell
//        cell.saveButton.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        //cell.textLabel!.text = "ads"
        return cell
    }
}
