//
//  TabmanStaticBarTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
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
        guard let bar = tabmanBar else {
            return
        }
        
        var barWidth = bounds.size.width
        if #available(iOS 11, *) {
            barWidth -= (bar.safeAreaInsets.left + bar.safeAreaInsets.right)
        }
        
        // account for padding if using a button bar.
        var indicatorPadding: CGFloat = 0.0
        if let buttonBar = bar as? TabmanButtonBar {
            indicatorPadding = buttonBar.edgeInset
            barWidth -= indicatorPadding * 2
        }
        
        let itemCount = CGFloat(bar.items?.count ?? 0)
        let itemWidth = barWidth / itemCount
        
        if bar.indicatorIsProgressive {
            
            let relativePosition = (position + 1.0) / CGFloat((bar.items?.count ?? 1))
            let indicatorWidth = max(0.0, barWidth * relativePosition)
            
            var bouncyIndicatorWidth = indicatorWidth
            if !bar.indicatorBounces && !bar.indicatorCompresses {
                bouncyIndicatorWidth = max(itemWidth, min(barWidth, bouncyIndicatorWidth))
            }
            bar.indicatorLeftMargin?.constant = 0.0
            bar.indicatorWidth?.constant = max(0.0, bouncyIndicatorWidth + indicatorPadding)
            
        } else {
            
            let relativePosition = position / CGFloat((bar.items?.count ?? 1))
            let leftMargin = relativePosition * barWidth
            
            let isOutOfBounds = position < 0.0 || position > (itemCount - 1.0)
            
            var indicatorLeftMargin = leftMargin
            var indicatorWidth = itemWidth
            
            // dont bounce indicator if required
            if !bar.indicatorBounces && isOutOfBounds {
                indicatorLeftMargin = max(0.0, min(barWidth - itemWidth, indicatorLeftMargin))
            }
            
            // compress indicator at boundaries if required
            if bar.indicatorCompresses && isOutOfBounds {
                var integral: Float = 0.0
                let progress = CGFloat(modff(Float(position), &integral))

                let indicatorDiff = (indicatorWidth * abs(progress))
                indicatorWidth -= indicatorDiff
                
                if progress > 0.0 {
                    indicatorLeftMargin += indicatorDiff
                }
            }
            
            bar.indicatorLeftMargin?.constant = indicatorLeftMargin + indicatorPadding
            bar.indicatorWidth?.constant = max(0.0, indicatorWidth)
        }
    }
}
