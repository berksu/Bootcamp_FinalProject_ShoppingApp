//
//  ViewControllerPreview.swift
//  Shopee
//
//  Created by Berksu Kısmet on 1.11.2022.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
struct ViewControllerPreview: UIViewControllerRepresentable {
    let viewControllerBuilder: () -> UIViewController

    init(_ viewControllerBuilder: @escaping () -> UIViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewControllerBuilder()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Not needed
    }
}
