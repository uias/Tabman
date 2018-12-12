//
//  NavigationControllerUtils.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 10/04/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }
}
