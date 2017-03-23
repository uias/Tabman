//
//  TabmanStaticButtonBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 16/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Pageboy
import PureLayout

/// Concrete class for a static button bar with item limit of 5.
internal class TabmanStaticButtonBar: TabmanButtonBar {
    
    //
    // MARK: Properties
    //
    
    override public var itemCountLimit: Int? {
        return 5
    }
    
    //
    // MARK: Lifecycle
    //
    
    override func indicatorTransitionType() -> TabmanIndicatorTransition.Type? {
        return TabmanStaticBarIndicatorTransition.self
    }
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    override public func addIndicatorToBar(indicator: TabmanIndicator) {
        
        self.contentView.addSubview(indicator)
        indicator.autoPinEdge(toSuperviewEdge: .bottom)
        self.indicatorLeftMargin = indicator.autoPinEdge(toSuperviewEdge: .left)
        self.indicatorWidth = indicator.autoSetDimension(.width, toSize: 0.0)
    }
}
