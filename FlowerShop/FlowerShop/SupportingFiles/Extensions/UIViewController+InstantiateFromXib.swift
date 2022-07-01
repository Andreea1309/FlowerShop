//
//  UIViewController+InstantiateFromXib.swift
//  FlowerShop
//
//  Created by andreea.ungureanu on 30.06.2022.
//

import UIKit

extension UIViewController {
    class func instantiateFromXib() -> Self {
        let nibName = String(describing: self)
        let new = Self.init(nibName: nibName, bundle: nil)
        return new
    }
}
