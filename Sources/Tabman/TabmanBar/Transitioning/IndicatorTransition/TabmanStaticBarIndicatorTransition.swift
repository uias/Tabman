//
//  TabmanStaticBarTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Pageboy

/// Transition for updating a static bar.
/// Handles indicator maintaining current position.
class TabmanStaticBarIndicatorTransition: TabmanIndicatorTransition {

    override func transition(withPosition position: CGFloat,
                             direction: PageboyViewController.NavigationDirection,
                             indexRange: Range<Int>,
                             bounds: CGRect) {
        guard let bar = tabmanBar else { return }
        
        let barWidth = bounds.size.width
        let itemCount = CGFloat(bar.items?.count ?? 0)
        let itemWidth = barWidth / itemCount
        
        if bar.indicatorIsProgressive {
            
            let relativePosition = (position + 1.0) / CGFloat((bar.items?.count ?? 1))
            let indicatorWidth = max(0.0, min(barWidth, barWidth * relativePosition))
            
            var bouncyIndicatorWidth = indicatorWidth
            if !bar.indicatorBounces {
                bouncyIndicatorWidth = max(itemWidth, min(barWidth, bouncyIndicatorWidth))
            }
            bar.indicatorLeftMargin?.constant = 0.0
            bar.indicatorWidth?.constant = bouncyIndicatorWidth
            
        } else {
            
            let relativePosition = position / CGFloat((bar.items?.count ?? 1))
            let leftMargin = relativePosition * barWidth
            
            var bouncyIndicatorPosition = leftMargin
            if !bar.indicatorBounces {
                bouncyIndicatorPosition = max(0.0, min(barWidth - itemWidth, bouncyIndicatorPosition))
            }
            bar.indicatorLeftMargin?.constant = bouncyIndicatorPosition
            bar.indicatorWidth?.constant = itemWidth
        }
    }
}
