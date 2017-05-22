//
//  Appearance+Layout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/05/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

// MARK: - TabmanBar layout appearance properties.
extension TabmanBar.Appearance {

    /// The distribution of items within a TabmanBar.
    ///
    /// - leftAligned: Items will be laid out from the left of the bar.
    /// - centered: Items will be laid out from the center of the bar.
    public enum ItemDistribution {
        case leftAligned
        case centered
    }
    
    public struct Layout {
        /// The spacing between items in the bar.
        public var interItemSpacing: CGFloat?
        /// The spacing at the edge of the items in the bar.
        public var edgeInset: CGFloat?
        /// The height for the bar.
        public var height: TabmanBar.Height?
        /// The vertical padding between the item and the bar bounds.
        public var itemVerticalPadding: CGFloat?
        /// How items in the bar should be distributed.
        public var itemDistribution: ItemDistribution?
    }
}
