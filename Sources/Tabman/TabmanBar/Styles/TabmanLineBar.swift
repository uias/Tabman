//
//  TabmanLineBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
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
    
    public override func construct(in contentView: UIView,
                                   for items: [TabmanBar.Item]) {
        
    }
    
    public override func add(indicator: TabmanIndicator, to contentView: UIView) {
        
        indicator.tintColor = self.appearance.indicator.color
        contentView.addSubview(indicator)
        self.indicatorLeftMargin = indicator.pinToSuperviewEdge(.left)
        indicator.pinToSuperviewEdge(.top)
        indicator.pinToSuperviewEdge(.bottom)
        self.indicatorWidth = indicator.set(.width, to: 0.0)
    }
}
