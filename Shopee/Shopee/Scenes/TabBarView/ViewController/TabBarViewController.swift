//
//  TabBarViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 29.10.2022.
//

import UIKit

final class TabBarViewController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // Create all of the tabs and icons of the tabs
    func setupViewControllers(){
        viewControllers = [
            createNavigationController(for: ProductScreenViewController(),
                                       title: NSLocalizedString("Products", comment: ""),
                                       unselectedImage: UIImage(named:"homeIcon")!,
                                       selectedImage: UIImage(named:"homeIconFilled")!),
            createNavigationController(for: ViewController(),
                                       title: NSLocalizedString("Search", comment: ""),
                                       unselectedImage: UIImage(named:"searchIcon")!,
                                       selectedImage: UIImage(named:"searchIcon")!),
            createNavigationController(for: ViewController(),
                                       title: NSLocalizedString("Profile", comment: ""),
                                       unselectedImage: UIImage(named:"profileIcon")!,
                                       selectedImage: UIImage(named:"profileIconFilled")!)
        ]
    }
    
    private func createNavigationController(for rootViewController: UIViewController,
                                            title: String,
                                            unselectedImage: UIImage,
                                            selectedImage: UIImage) -> UIViewController{
        // add navigation controller to each tab
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
<<<<<<< Updated upstream
        navigationController.tabBarItem.image = image
<<<<<<< HEAD
        //navigationController.navigationBar.prefersLargeTitles = true
        //rootViewController.navigationItem.title = title
=======
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
=======
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        //navigationController.navigationBar.prefersLargeTitles = true
        //rootViewController.navigationItem.title = title
>>>>>>> Stashed changes
>>>>>>> Feature/TabBarView
        return navigationController
    }
}
