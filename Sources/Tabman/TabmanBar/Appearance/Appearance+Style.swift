//
//  Appearance+Style.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/05/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

// MARK: - TabmanBar style appearance properties. 
extension TabmanBar.Appearance {
    
    public struct Style {
        /// The background style for the bar.
        public var background: TabmanBarBackgroundView.BackgroundStyle?
        /// Whether to show a fade on the items at the bounds edge of a scrolling button bar.
        public var showEdgeFade: Bool?
        /// Color of the separator at the bottom of the bar.
        public var bottomSeparatorColor: UIColor?
    }
}
