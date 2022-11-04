//
//  BasketButton.swift
//  Shopee
//
//  Created by Berksu Kısmet on 3.11.2022.
//

import UIKit

class BasketButton: UIButton {
    var cell: BasketTableViewCustomCell?
    var index: Int?
}

class ScrollableStackButton: UIButton {
    var isTapped: Bool = false
}
