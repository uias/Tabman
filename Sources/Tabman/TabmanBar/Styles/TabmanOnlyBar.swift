//
//  TabmanOnlyBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout
import Pageboy

public class TabmanOnlyBar: TabmanBar {

    //
    // MARK: Properties
    //
    
    // Public
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 2.0)
    }
    
    //
    // MARK: Lifecycle
    //
    
    public override func indicatorStyle() -> TabmanIndicator.Style {
        return .line
    }
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    override public func constructTabBar(items: [TabmanBarItem]) {
        super.constructTabBar(items: items)
        
        if let indicator = self.indicator {
            indicator.tintColor = self.appearance.indicator.color
            self.containerView.addSubview(indicator)
            self.indicatorLeftMargin = indicator.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .right)[1]
            self.indicatorWidth = indicator.autoSetDimension(.width, toSize: 0.0)
        }
    }
    
    override public func update(forPosition position: CGFloat,
                         direction: PageboyViewController.NavigationDirection,
                         minimumIndex: Int,
                         maximumIndex: Int) {
        super.update(forPosition: position,
                     direction: direction,
                     minimumIndex: minimumIndex,
                     maximumIndex: maximumIndex)
        
        let screenWidth = self.bounds.size.width
        let itemCount = CGFloat(self.items?.count ?? 0)
        let itemWidth = screenWidth / itemCount

        if self.indicatorIsProgressive {
            
            let relativePosition = (position + 1.0) / CGFloat((self.items?.count ?? 1))
            let indicatorWidth = max(0.0, min(screenWidth, screenWidth * relativePosition))
            
            var bouncyIndicatorWidth = indicatorWidth
            if !self.indicatorBounces {
                bouncyIndicatorWidth = max(itemWidth, min(screenWidth, bouncyIndicatorWidth))
            }
            self.indicatorWidth?.constant = bouncyIndicatorWidth
            
        } else {
            
            let relativePosition = position / CGFloat((self.items?.count ?? 1))
            let leftMargin = relativePosition * screenWidth
            
            var bouncyIndicatorPosition = leftMargin
            if !self.indicatorBounces {
                bouncyIndicatorPosition = max(0.0, min(screenWidth - itemWidth, bouncyIndicatorPosition))
            }
            self.indicatorLeftMargin?.constant = bouncyIndicatorPosition
            self.indicatorWidth?.constant = itemWidth
        }
    }
    
    override public func update(forAppearance appearance: TabmanBar.AppearanceConfig) {
        super.update(forAppearance: appearance)
        
        if let indicatorColor = appearance.indicator.color {
            self.indicator?.tintColor = indicatorColor
        }
    }
}
