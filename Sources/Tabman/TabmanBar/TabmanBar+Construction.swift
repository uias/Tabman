//
//  TabmanBar+Construction.swift
//  Tabman
//
//  Created by Merrick Sapsford on 15/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout
import Pageboy

// MARK: - TabmanBar construction
extension TabmanBar {

    /// Reconstruct the bar for a new style or data set.
    internal func clearAndConstructBar() {
        self.indicatorWidth?.isActive = false
        self.indicatorLeftMargin?.isActive = false
        self.clearBar()
        
        guard let items = self.items else { return } // no items yet
        
        self.constructTabBar(items: items)
        if let indicator = self.indicator {
            self.addIndicatorToBar(indicator: indicator)
        }
        
        self.updateCore(forAppearance: self.appearance)
        self.updateForCurrentPosition()
    }
    
    /// Remove all components and subviews from the bar.
    internal func clearBar() {
        self.contentView.removeAllSubviews()
    }
    
}
