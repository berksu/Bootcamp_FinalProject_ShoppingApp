//
//  ImagePickerViewController.swift
//  Shopee
//
//  Created by Berksu Kısmet on 6.11.2022.
//

import UIKit

class ImagePickerViewController: UIViewController {

    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        return iv
    }()
    
    let showImagepickerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Choose", for: .normal)
        button.tintColor = .black
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        return button
    }()

    var imagePicker: ImagePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        view.addSubview(showImagepickerButton)
        showImagepickerButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }

        showImagepickerButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }

    @objc func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
}

extension ImagePickerViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageView.image = image
    }
}



