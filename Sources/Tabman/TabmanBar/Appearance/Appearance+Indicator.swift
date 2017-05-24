//
//  Appearance+Indicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/05/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

// MARK: - TabmanBar Indicator appearance properties.
public extension TabmanBar.Appearance {
    
    public struct Indicator {
        /// The preferred style to use for the indicator.
        /// This is optionally conformed to by the bar.
        public var preferredStyle: TabmanIndicator.Style?
        /// The color of the bar indicator.
        public var color: UIColor?
        /// The weight (thickness) of the bar indicator if using a line indicator.
        public var lineWeight: TabmanIndicator.LineWeight?
        /// Whether the indicator transiton is progressive.
        public var isProgressive: Bool?
        /// Whether the indicator bounces at the end of page ranges.
        public var bounces: Bool?
        /// Whether the indicator compresses at the end of page ranges (Unavailable if bounces enabled).
        public var compresses: Bool?
        /// Whether to use rounded corners on line indicators.
        public var useRoundedCorners: Bool?
    }
}
