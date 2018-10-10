//
//  TMInsets.swift
//  Tabman
//
//  Created by Merrick Sapsford on 10/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import AutoInsetter

public final class TMInsets {
    
    class func `for`(tabmanViewController: TabmanViewController) -> TMInsets {
        tabmanViewController.view.layoutIfNeeded()
        return TMInsets(tabmanViewController: tabmanViewController)
    }
    
    // MARK: Properties
    
    public let safeAreaInsets: UIEdgeInsets
    public let edgeInsets: UIEdgeInsets
    
    // MARK: Init
    
    private init(tabmanViewController: TabmanViewController) {
        self.safeAreaInsets = TMInsets.makeSafeAreaInsets(for: tabmanViewController)
        self.edgeInsets = UIEdgeInsets(top: tabmanViewController.topBarContainer.bounds.size.height,
                                       left: 0.0,
                                       bottom: tabmanViewController.bottomBarContainer.bounds.size.height,
                                       right: 0.0)
    }
}

private extension TMInsets {
    
    class func makeSafeAreaInsets(for viewController: UIViewController) -> UIEdgeInsets {
        if #available(iOS 11, *) {
            return viewController.view.safeAreaInsets
        } else {
            let topLayoutGuideLength = viewController.topLayoutGuide.length
            let bottomLayoutGuideLength = viewController.bottomLayoutGuide.length
            
            return UIEdgeInsets(top: topLayoutGuideLength,
                                left: 0.0,
                                bottom: bottomLayoutGuideLength,
                                right: 0.0)
        }
    }
}

extension TMInsets: AutoInsetSpec {
    
    public var allRequiredInsets: UIEdgeInsets {
        return UIEdgeInsets(top: safeAreaInsets.top + edgeInsets.top,
                            left: safeAreaInsets.left + edgeInsets.left,
                            bottom: safeAreaInsets.bottom + edgeInsets.bottom,
                            right: safeAreaInsets.right + edgeInsets.right)
    }
    
    public var additionalRequiredInsets: UIEdgeInsets {
        return edgeInsets
    }
}
