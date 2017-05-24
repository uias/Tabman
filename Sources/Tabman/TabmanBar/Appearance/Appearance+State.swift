//
//  Appearance+State.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/05/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

// MARK: - TabmanBar state appearance properties.
extension TabmanBar.Appearance {
    
    public struct State {
        /// The color to use for selected items in the bar (text/images etc.).
        public var selectedColor: UIColor?
        /// The text color to use for unselected items in the bar (text/images etc.).
        public var color: UIColor?
    }
}
