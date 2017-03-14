//
//  TabmanStaticBarTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Pageboy

class TabmanStaticBarIndicatorTransition: TabmanIndicatorTransition {

    var tabmanBar: TabmanBar?
    
    func transition(withPosition position: CGFloat,
                    direction: PageboyViewController.NavigationDirection,
                    minimumIndex: Int, maximumIndex: Int) {
        guard let bar = tabmanBar else { return }
        
        let screenWidth = bar.bounds.size.width
        let itemCount = CGFloat(bar.items?.count ?? 0)
        let itemWidth = screenWidth / itemCount
        
        if bar.indicatorIsProgressive {
            
            let relativePosition = (position + 1.0) / CGFloat((bar.items?.count ?? 1))
            let indicatorWidth = max(0.0, min(screenWidth, screenWidth * relativePosition))
            
            var bouncyIndicatorWidth = indicatorWidth
            if !bar.indicatorBounces {
                bouncyIndicatorWidth = max(itemWidth, min(screenWidth, bouncyIndicatorWidth))
            }
            bar.indicatorWidth?.constant = bouncyIndicatorWidth
            
        } else {
            
            let relativePosition = position / CGFloat((bar.items?.count ?? 1))
            let leftMargin = relativePosition * screenWidth
            
            var bouncyIndicatorPosition = leftMargin
            if !bar.indicatorBounces {
                bouncyIndicatorPosition = max(0.0, min(screenWidth - itemWidth, bouncyIndicatorPosition))
            }
            bar.indicatorLeftMargin?.constant = bouncyIndicatorPosition
            bar.indicatorWidth?.constant = itemWidth
        }
    }
    
    func updateForCurrentPosition() {
        
    }
}
