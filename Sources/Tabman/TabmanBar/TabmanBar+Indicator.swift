//
//  TabmanBar+Indicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 15/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

// MARK: - TabmanBar Indicator creation and mutation
extension TabmanBar {

    /// Remove a scroll indicator from the bar.
    internal func clear(indicator: TabmanIndicator?) {
        self.indicatorMaskView.frame = .zero // reset mask
        indicator?.removeFromSuperview()
        indicator?.removeConstraints(indicator?.constraints ?? [])
    }
    
    /// Create a new indicator for a style.
    ///
    /// - Parameter style: The style.
    /// - Returns: The new indicator.
    internal func create(indicatorForStyle style: TabmanIndicator.Style) -> TabmanIndicator? {
        if let indicatorType = style.rawType {
            return indicatorType.init()
        }
        return nil
    }
    
    /// Update the current indicator for a preferred style.
    ///
    /// - Parameter preferredStyle: The new preferred style.
    internal func updateIndicator(forPreferredStyle preferredStyle: TabmanIndicator.Style?) {
        guard let preferredIndicatorStyle = self.preferredIndicatorStyle else {
            
            // restore default if no preferred style
            self.indicator = self.create(indicatorForStyle: self.defaultIndicatorStyle())
            guard let indicator = self.indicator else {
                return
            }
            add(indicator: indicator, to: contentView)
            self.updateForCurrentPosition()
            
            return
        }
        guard self.usePreferredIndicatorStyle() else {
            return
        }
        
        // return nil if same type as current indicator
        if let indicator = self.indicator {
            guard type(of: indicator) != preferredStyle?.rawType else {
                return
            }
        }
        
        // Create new preferred style indicator.
        self.indicator = self.create(indicatorForStyle: preferredIndicatorStyle)
        guard let indicator = self.indicator else {
            return
        }
        
        // disable progressive indicator if indicator does not support it. 
        if self.indicator?.isProgressiveCapable == false && self.indicatorIsProgressive {
            self.indicatorIsProgressive = false
        }
        
        add(indicator: indicator, to: contentView)
        self.updateForCurrentPosition()
    }

}
