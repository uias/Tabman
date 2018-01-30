//
//  TabmanBar+Construction.swift
//  Tabman
//
//  Created by Merrick Sapsford on 15/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

// MARK: - TabmanBar construction
extension TabmanBar {

    /// Reconstruct the bar for a new style or data set.
    internal func clearAndConstructBar() {
        self.indicatorWidth?.isActive = false
        self.indicatorLeftMargin?.isActive = false
        self.clearBar()
        
        // no items yet
        guard let items = self.items else {
            return
        }
        
        construct(in: contentView, for: items)
        if let indicator = self.indicator {
            add(indicator: indicator, to: contentView)
        }
        
        behaviorEngine.update(activation: .onBarChange)
        self.updateCore(forAppearance: self.appearance)
        self.updateForCurrentPosition()
    }
    
    /// Remove all components and subviews from the bar.
    internal func clearBar() {
        self.contentView.removeAllSubviews()
    }
    
}
