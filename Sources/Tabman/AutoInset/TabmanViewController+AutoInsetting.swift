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
        guard let currentViewController = self.currentViewController else {
            return
        }
        setNeedsChildAutoInsetUpdate(for: currentViewController)
    }
    
    func setNeedsChildAutoInsetUpdate(for childViewController: UIViewController) {
        autoInsetEngine.inset(childViewController, requiredInsets: bar.requiredInsets)
    }
}
