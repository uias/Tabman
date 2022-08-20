//
//  UIKit+TMBarItem.swift
//  Tabman
//
//  Created by Merrick Sapsford on 19/10/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

/// :nodoc:
extension UINavigationItem: TMBarItemable {

    // swiftlint:disable unused_setter_value

    public var image: UIImage? {
        get {
            return nil
        }
        set {}
    }
    
    public var selectedImage: UIImage? {
        get {
            return nil
        }
        set {}
    }
    
    public var badgeValue: String? {
        get {
            return nil
        }
        set {}
    }
}

/// :nodoc:
extension UITabBarItem: TMBarItemable {
}
