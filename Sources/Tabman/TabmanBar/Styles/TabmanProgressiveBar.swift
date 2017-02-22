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
    
    private var indicatorWidthConstraint: NSLayoutConstraint!
    
    // Public
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 4.0)
    }
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    override func constructTabBar(items: [TabmanBarItem]) {
        super.constructTabBar(items: items)
        
        self.containerView.addSubview(indicator)
        indicator.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .right)
        self.indicatorWidthConstraint = indicator.autoSetDimension(.width, toSize: 0.0)
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
        let relativePosition = (position + 1.0) / CGFloat((self.items?.count ?? 1))
        
        let indicatorWidth = max(0.0, min(screenWidth, screenWidth * relativePosition))
        self.indicatorWidthConstraint.constant = indicatorWidth
    }
    
    override func update(forAppearance appearance: TabmanBar.AppearanceConfig) {
        super.update(forAppearance: appearance)
        
    }
}
