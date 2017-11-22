//
//  TabmanViewController+AutoInsetting.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import UIKit

internal extension TabmanViewController {
    
    func setNeedsChildAutoInsetUpdate() {
        setNeedsChildAutoInsetUpdate(for: currentViewController)
    }
    
    func setNeedsChildAutoInsetUpdate(for childViewController: UIViewController?) {
        guard let childViewController = childViewController else {
            return
        }
        autoInsetEngine.inset(childViewController, requiredInsets: bar.requiredInsets)
    }
}
