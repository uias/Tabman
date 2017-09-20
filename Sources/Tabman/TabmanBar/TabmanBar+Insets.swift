//
//  TabmanBarInsets.swift
//  Pods
//
//  Created by Merrick Sapsford on 10/05/2017.
//
//

import Foundation

public extension TabmanBar {
    
    /// Collection of inset values required to inset child content below TabmanBar.
    public struct Insets {
        
        /// Raw TabmanBar UIEdgeInsets
        internal let barInsets: UIEdgeInsets
        
        /// The inset required for the top layout guide (UINavigationBar etc.).
        @available(*, deprecated: 1.0.1, message: "Use safeAreaInsets")
        public var topLayoutGuide: CGFloat {
            return safeAreaInsets.top
        }
        /// The inset required for the bottom layout guide (UITabBar etc.).
        @available(*, deprecated: 1.0.1, message: "Use safeAreaInsets")
        public var bottomLayoutGuide: CGFloat {
            return safeAreaInsets.bottom
        }
        /// The insets that determine the safe area for the view controller view.
        public let safeAreaInsets: UIEdgeInsets
        /// The inset required for the bar.
        public var bar: CGFloat {
            return max(barInsets.top, barInsets.bottom)
        }
        
        /// The total insets required to display under the TabmanBar.
        ///
        /// This takes topLayoutGuide, bottomlayoutGuide and the bar height into account.
        /// Set on a UIScrollView's contentInset to manually inset the contents.
        public var all: UIEdgeInsets {
            let top = safeAreaInsets.top + barInsets.top
            let bottom = safeAreaInsets.bottom + barInsets.bottom
            
            if barInsets.top > 0.0 {
                return UIEdgeInsetsMake(top, 0.0, 0.0, 0.0)
            } else {
                return UIEdgeInsetsMake(0.0, 0.0, bottom, 0.0)
            }
        }
        
        // MARK: Init
        
        internal init(safeAreaInsets: UIEdgeInsets,
                      bar: UIEdgeInsets) {
            self.safeAreaInsets = safeAreaInsets
            self.barInsets = bar
        }
        
        internal init() {
            self.init(safeAreaInsets: .zero,
                      bar: .zero)
        }
        
        internal static var zero: Insets {
            return Insets()
        }
        
    }

}

