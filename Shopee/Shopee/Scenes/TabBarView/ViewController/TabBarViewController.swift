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
                                       image: UIImage(named:"homeIcon")!),
            createNavigationController(for: ViewController(),
                                       title: NSLocalizedString("Search", comment: ""),
                                       image: UIImage(named:"searchIcon")!),
            createNavigationController(for: ViewController(),
                                       title: NSLocalizedString("Profile", comment: ""),
                                       image: UIImage(named:"profileIcon")!)
        ]
    }
    
    private func createNavigationController(for rootViewController: UIViewController,
                                                title: String,
                                                image: UIImage) -> UIViewController{
        // add navigation controller to each tab
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        //navigationController.navigationBar.prefersLargeTitles = true
        //rootViewController.navigationItem.title = title
        return navigationController
    }
}
