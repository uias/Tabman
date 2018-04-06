//
//  UIViewController+AutoInsetting.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

public extension UIViewController {
    
    /// Indicates to the TabmanViewController that a child scroll view inset
    /// needs to be updated.
    ///
    /// This should be called if the contentInset of a UITableView or UICollectionView is changed
    /// after viewDidLoad.
    public func setNeedsScrollViewInsetUpdate() {
        guard let tabmanViewController = self.parentPageboy as? TabmanViewController else {
            return
        }
        tabmanViewController.setNeedsChildAutoInsetUpdate(for: self)
    }
}
