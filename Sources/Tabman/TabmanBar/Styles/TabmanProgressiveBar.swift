//
//  TabmanProgressiveBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout
import Pageboy

public class TabmanProgressiveBar: TabmanBar {

    //
    // MARK: Properties
    //
    
    // Private
    
    private var indicator = TabmanLineIndicator(forAutoLayout: ())
    
    // Public
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 2.0)
    }
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    override func constructTabBar(items: [TabmanBarItem]) {
        super.constructTabBar(items: items)
        
        self.containerView.addSubview(indicator)
        self.indicatorLeftMargin = indicator.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .right)[1]
        self.indicatorWidth = indicator.autoSetDimension(.width, toSize: 0.0)
    }
    
    override func update(forPosition position: CGFloat,
                         direction: PageboyViewController.NavigationDirection,
                         minimumIndex: Int,
                         maximumIndex: Int) {
        super.update(forPosition: position,
                     direction: direction,
                     minimumIndex: minimumIndex,
                     maximumIndex: maximumIndex)
        
        let screenWidth = self.bounds.size.width

        if self.indicatorIsProgressive {
            
            let relativePosition = (position + 1.0) / CGFloat((self.items?.count ?? 1))
            let indicatorWidth = max(0.0, min(screenWidth, screenWidth * relativePosition))
            self.indicatorWidth?.constant = indicatorWidth
            
        } else {
            
            let itemCount = CGFloat(self.items?.count ?? 0)
            let itemWidth = screenWidth / itemCount
            
            let relativePosition = position / CGFloat((self.items?.count ?? 1))
            self.indicatorLeftMargin?.constant = relativePosition * screenWidth
            self.indicatorWidth?.constant = itemWidth
        }
    }
    
    override func update(forAppearance appearance: TabmanBar.AppearanceConfig) {
        super.update(forAppearance: appearance)
        
        if let indicatorColor = appearance.indicator.color {
            self.indicator.tintColor = indicatorColor
        }
    }
}
