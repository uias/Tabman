//
//  UIViewController+Tabman.swift
//  Tabman
//
//  Created by Merrick Sapsford on 23/02/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

public extension UIViewController {
    
    /// Parent TabmanViewController if it exists.
    public var tabmanParent: TabmanViewController? {
        return parentPageboy as? TabmanViewController
    }
}
