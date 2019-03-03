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
        return pageboyParent as? TabmanViewController
    }
    
    /// All bar items that are associated with the index of this view controller
    /// if within within a `TabmanViewController`.
    public var tabmanBarItems: [TMBarItemable]? {
        guard let tabViewController = tabmanParent, let index = pageboyPageIndex else {
            return nil
        }
        
        var allItems = [TMBarItemable]()
        tabViewController.bars.forEach({
            guard let items = $0.items, items.count > index else {
                return
            }
            allItems.append(items[index])
        })
        return allItems
    }
}
