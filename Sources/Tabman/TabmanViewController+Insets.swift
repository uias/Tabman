//
//  TabmanViewController+Insets.swift
//  Tabman
//
//  Created by Merrick Sapsford on 10/10/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit
import AutoInsetter

extension TabmanViewController {
    
    /// Object containing inset data that is required for all bars in a `TabmanViewController`.
    public struct Insets {
        
        static func `for`(tabmanViewController: TabmanViewController) -> Insets {
            tabmanViewController.view.layoutIfNeeded()
            return Insets(tabmanViewController: tabmanViewController)
        }
        
        // MARK: Properties
        
        /// The safe area insets of the `TabmanViewController`.
        public let safeAreaInsets: UIEdgeInsets
        /// The insets required for all bars in the `TabmanViewController`
        public let barInsets: UIEdgeInsets
        
        /// Inset specification for AutoInsetter.
        internal var spec: AutoInsetSpec {
            return InsetsSpec(allRequiredInsets: UIEdgeInsets(top: safeAreaInsets.top + barInsets.top,
                                                              left: safeAreaInsets.left + barInsets.left,
                                                              bottom: safeAreaInsets.bottom + barInsets.bottom,
                                                              right: safeAreaInsets.right + barInsets.right),
                              additionalRequiredInsets: barInsets)
        }
        
        // MARK: Init
        
        private init(tabmanViewController: TabmanViewController) {
            let safeAreaInsets = Insets.makeSafeAreaInsets(for: tabmanViewController)
            let barInsets = UIEdgeInsets(top: tabmanViewController.topBarContainer.bounds.size.height,
                                         left: 0.0,
                                         bottom: tabmanViewController.bottomBarContainer.bounds.size.height,
                                         right: 0.0)
            
            self.init(barInsets: barInsets, safeAreaInsets: safeAreaInsets)
        }
        
        public init(barInsets: UIEdgeInsets, safeAreaInsets: UIEdgeInsets) {
            self.barInsets = barInsets
            self.safeAreaInsets = safeAreaInsets
        }
        
        // MARK: Utility
        
        public static func makeSafeAreaInsets(for viewController: UIViewController) -> UIEdgeInsets {
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
}

extension TabmanViewController {
    
    /// Spec for AutoInsetter
    internal struct InsetsSpec: AutoInsetSpec {
        
        let allRequiredInsets: UIEdgeInsets
        let additionalRequiredInsets: UIEdgeInsets
    }
}
