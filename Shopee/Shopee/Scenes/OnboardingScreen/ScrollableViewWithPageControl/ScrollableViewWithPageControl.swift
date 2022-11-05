//
//  ScrollableViewWithPageControl.swift
//  Shopee
//
//  Created by Berksu Kısmet on 5.11.2022.
//

import UIKit

final class ScrollableViewWithPageControl: UIView{
    
    let skipButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.tintColor = .white
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)!
        button.layer.cornerRadius = 10
        button.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        return button
    }()
    
    private let backgroundView = UIView()

    var scrollView = UIScrollView()
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    private var viewFrame: CGRect = CGRect()
    var pageControl : UIPageControl = UIPageControl()

    var previousPageButton: UIButton = {
       var button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.isHidden = true
        button.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        return button
    }()
    
    var nextPageButton: UIButton = {
       var button = UIButton()
        button.setImage(UIImage(named: "rightArrow"), for: .normal)
        button.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        return button
    }()
    
    private let imagesArray = ["chooseProduct","chooseCategory", "basket", "cart", "search"]
    var totalPageNumber: Int{
        imagesArray.count
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .white
        // Do any additional setup after loading the view, typically from a nib.
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: CGFloat.screenWidth, height: CGFloat.screenHeight))
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height)
        }
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: CGFloat.screenWidth, height: CGFloat.screenHeight))
        addSubview(scrollView)

        configurePageControl()

        for index in 0..<totalPageNumber {
            viewFrame.origin.x = scrollView.frame.size.width * CGFloat(index)
            viewFrame.size = scrollView.frame.size

            let subView = UIView(frame: viewFrame)
            subView.backgroundColor = .white
            
            setProductImageView(subView: subView, image: imagesArray[index])
            scrollView.addSubview(subView)
        }
        
        configureScrollView()
        
        addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        
        addSubview(previousPageButton)
        previousPageButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.centerY.equalTo(pageControl.snp.centerY)
        }
        
        addSubview(nextPageButton)
        nextPageButton.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.centerY.equalTo(pageControl.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureScrollView(){
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(totalPageNumber), height: scrollView.frame.size.height)
    }

    func configurePageControl() {
        pageControl.numberOfPages = totalPageNumber
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = UIColor.green
        addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView.snp.bottom).offset(-20)
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    func setProductImageView(subView: UIView, image: String){
        let productImageView = UIImageView()
        
        productImageView.image = UIImage(named: image)
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 10
      
        subView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.centerY.equalTo(subView.snp.centerY)
            make.centerX.equalTo(subView.snp.centerX)
            make.width.equalTo(subView.snp.width)
            make.height.equalTo(subView.snp.height)
        }
    }

}
