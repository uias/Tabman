//
//  TabmanViewController+Insets.swift
//  Tabman
//
//  Created by Merrick Sapsford on 10/10/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

extension TabmanViewController {
    
    /// Object containing inset data that is required for all bars in a `TabmanViewController`.
    public struct Insets {
        
        static func `for`(_ viewController: TabmanViewController) -> Insets {
            return Insets(viewController: viewController)
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
        
        private init(viewController: TabmanViewController) {
            let safeAreaInsets = viewController.view.safeAreaInsets
            let barInsets = UIEdgeInsets(top: viewController.topBarContainer.bounds.size.height,
                                         left: 0.0,
                                         bottom: viewController.bottomBarContainer.bounds.size.height,
                                         right: 0.0)
            
            self.init(barInsets: barInsets, safeAreaInsets: safeAreaInsets)
        }
        
        public init(barInsets: UIEdgeInsets, safeAreaInsets: UIEdgeInsets) {
            self.barInsets = barInsets
            self.safeAreaInsets = safeAreaInsets
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
