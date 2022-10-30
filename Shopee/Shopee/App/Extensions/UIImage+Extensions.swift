//
//  UIImage+Extensions.swift
//  Shopee
//
//  Created by Berksu Kısmet on 30.10.2022.
//

import UIKit

extension UIImage {
    // MARK: - For Previous versions of ios13, change UIImage tint color. After ios13, we have a method for that reason(withTintColor(_ color: UIColor))
    func withColor(_ color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        // 1
        let drawRect = CGRect(x: 0,y: 0,width: size.width,height: size.height)
        // 2
        color.setFill()
        UIRectFill(drawRect)
        // 3
        draw(in: drawRect, blendMode: .destinationIn, alpha: 1)

        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}
