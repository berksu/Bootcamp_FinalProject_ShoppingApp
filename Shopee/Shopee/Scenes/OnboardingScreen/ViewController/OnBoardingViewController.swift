//
//  OnBoardingViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 5.11.2022.
//

import UIKit

final class OnBoardingViewController: UIViewController, UIScrollViewDelegate{

    let scrollableViewWithPageControl = ScrollableViewWithPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = scrollableViewWithPageControl

        scrollableViewWithPageControl.scrollView.delegate = self
        scrollableViewWithPageControl.pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        
        scrollableViewWithPageControl.previousPageButton.addTarget(self, action: #selector(previousPageButtonTapped), for: .touchUpInside)
        scrollableViewWithPageControl.nextPageButton.addTarget(self, action: #selector(nextPageButtonTapped), for: .touchUpInside)
        scrollableViewWithPageControl.skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: -PreviousPageButton clicked
    @objc func previousPageButtonTapped(sender: UIButton){
        scrollableViewWithPageControl.pageControl.currentPage -= 1
        let x = CGFloat(scrollableViewWithPageControl.pageControl.currentPage) * scrollableViewWithPageControl.scrollView.frame.size.width
        scrollableViewWithPageControl.scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    
    // MARK: -NextPageButton clicked
    @objc func nextPageButtonTapped(sender: UIButton){
        if(scrollableViewWithPageControl.pageControl.currentPage == scrollableViewWithPageControl.pageControl.numberOfPages - 1){
            presentNextPage()
        }else{
            scrollableViewWithPageControl.pageControl.currentPage +=  1
            let x = CGFloat(scrollableViewWithPageControl.pageControl.currentPage) * scrollableViewWithPageControl.scrollView.frame.size.width
            scrollableViewWithPageControl.scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
        }
    }
    
    // MARK: -SkipButton clicked
    @objc func skipButtonTapped(sender: UIButton){
        presentNextPage()
    }
    
    func presentNextPage(){
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "isOboardingAlreadyShown")
        let authenticationViewController = AuthenticationViewController()
        self.navigationController?.pushViewController(authenticationViewController, animated: false)
    }
    
    func updateButtons(){
        let currentPage = scrollableViewWithPageControl.pageControl.currentPage
        
        // Previous page button configuration
        if currentPage == 0{
            scrollableViewWithPageControl.previousPageButton.isHidden = true
        }else{
            scrollableViewWithPageControl.previousPageButton.isHidden = false
        }

        // Next page button configuration
        if currentPage  == scrollableViewWithPageControl.pageControl.numberOfPages - 1{
            scrollableViewWithPageControl.nextPageButton.setImage(UIImage(named: "finishIcon"), for: .normal)
        }else{
            scrollableViewWithPageControl.nextPageButton.setImage(UIImage(named: "rightArrow"), for: .normal)
        }
    }
    
    // MARK: -TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(scrollableViewWithPageControl.pageControl.currentPage) * scrollableViewWithPageControl.scrollView.frame.size.width
        scrollableViewWithPageControl.scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    
    // MARK: -UISCROLLVIEW Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        scrollableViewWithPageControl.pageControl.currentPage = Int(pageNumber)
        updateButtons()
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updateButtons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
