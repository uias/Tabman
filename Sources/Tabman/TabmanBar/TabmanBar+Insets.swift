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
        public let topLayoutGuide: CGFloat
        /// The inset required for the bottom layout guide (UITabBar etc.).
        public let bottomLayoutGuide: CGFloat
        /// The inset required for the bar.
        public var bar: CGFloat {
            return max(barInsets.top, barInsets.bottom)
        }
        
        /// The total insets required to display under the TabmanBar.
        ///
        /// This takes topLayoutGuide, bottomlayoutGuide and the bar height into account.
        /// Set on a UIScrollView's contentInset to manually inset the contents.
        public var all: UIEdgeInsets {
            let top = topLayoutGuide + barInsets.top
            let bottom = bottomLayoutGuide + barInsets.bottom
            
            if barInsets.top > 0.0 {
                return UIEdgeInsetsMake(top, 0.0, 0.0, 0.0)
            } else {
                return UIEdgeInsetsMake(0.0, 0.0, bottom, 0.0)
            }
        }
        
        // MARK: Init
        
        internal init(topLayoutGuide: CGFloat,
                      bottomLayoutGuide: CGFloat,
                      bar: UIEdgeInsets) {
            self.topLayoutGuide = topLayoutGuide
            self.bottomLayoutGuide = bottomLayoutGuide
            self.barInsets = bar
        }
        
        internal init() {
            self.init(topLayoutGuide: 0.0,
                      bottomLayoutGuide: 0.0,
                      bar: .zero)
        }
        
        internal static var zero: Insets {
            return Insets()
        }
        
    }

}

