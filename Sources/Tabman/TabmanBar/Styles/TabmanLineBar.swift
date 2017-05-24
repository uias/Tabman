//
//  TabmanLineBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout
import Pageboy

/// A simple bar containing only a line indicator.
internal class TabmanLineBar: TabmanBar {

    // MARK: Properties
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 2.0)
    }
    
    // MARK: Lifecycle
    
    public override func defaultIndicatorStyle() -> TabmanIndicator.Style {
        return .line
    }
    
    public override func usePreferredIndicatorStyle() -> Bool {
        return false
    }
    
    override func indicatorTransitionType() -> TabmanIndicatorTransition.Type? {
        return TabmanStaticBarIndicatorTransition.self
    }
    
    // MARK: TabmanBar Lifecycle
    
    public override func constructTabBar(items: [TabmanBarItem]) {
        
    }
    
    public override func addIndicatorToBar(indicator: TabmanIndicator) {
        
        indicator.tintColor = self.appearance.indicator.color
        self.contentView.addSubview(indicator)
        self.indicatorLeftMargin = indicator.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .right)[1]
        self.indicatorWidth = indicator.autoSetDimension(.width, toSize: 0.0)
    }
}
