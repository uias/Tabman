//
//  CustomTabmanBar.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 03/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Tabman
import Pageboy
import PureLayout

class CustomTabmanBar: TabmanBar {

    // MARK: Lifecycle
    
    override var intrinsicContentSize: CGSize {
        // return your custom size here if required
        return super.intrinsicContentSize
    }
    
    override func defaultIndicatorStyle() -> TabmanIndicator.Style {
        // declare indicator style here
        return .none
    }
    
    override func usePreferredIndicatorStyle() -> Bool {
        // Whether to use prefferedIndicatorStyle
        return true
    }
    
    // MARK: TabmanBar Lifecycle
    
    override func constructTabBar(items: [TabmanBarItem]) {
        super.constructTabBar(items: items)
        
        // create your bar here
        let label = UILabel()
        label.text = "This is a custom TabmanBar"
        label.textAlignment = .center
        label.textColor = .white
        self.contentView.addSubview(label)
        label.autoPinEdgesToSuperviewEdges()
    }
    
    override func update(forPosition position: CGFloat,
                         direction: PageboyViewController.NavigationDirection,
                         minimumIndex: Int, maximumIndex: Int) {
        super.update(forPosition: position, direction: direction,
                     minimumIndex: minimumIndex, maximumIndex: maximumIndex)
        
        // update your bar for a positional update here
    }
    
    override func update(forAppearance appearance: TabmanBar.AppearanceConfig) {
        super.update(forAppearance: appearance)
        
        // update the bar appearance here
    }
}
