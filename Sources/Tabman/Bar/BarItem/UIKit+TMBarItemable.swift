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
    
    public var image: UIImage? {
        return nil
    }
}

/// :nodoc:
extension UITabBarItem: TMBarItemable {
}
