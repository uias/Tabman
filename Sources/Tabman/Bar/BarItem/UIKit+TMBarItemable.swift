//
//  UIKit+TMBarItem.swift
//  Tabman
//
//  Created by Merrick Sapsford on 19/10/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

/// :nodoc:
extension UINavigationItem: TMBarItemable {

    //swiftlint:disable unused_setter_value

    public var image: UIImage? {
        set {}
        get {
            return nil
        }
    }
    
    public var badgeValue: String? {
        set {}
        get {
            return nil
        }
    }
}

/// :nodoc:
extension UITabBarItem: TMBarItemable {
}
