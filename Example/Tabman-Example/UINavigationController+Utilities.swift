//
//  NavigationControllerUtils.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 10/04/2017.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    #if swift(>=4.2)
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    open override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }
    #else
    open override var childViewControllerForStatusBarStyle: UIViewController? {
        return topViewController
    }
    open override var childViewControllerForStatusBarHidden: UIViewController? {
        return topViewController
    }
    #endif
}
