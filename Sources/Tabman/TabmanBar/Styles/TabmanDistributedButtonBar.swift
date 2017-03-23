//
//  TabmanDistributedButtonBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 23/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout
import Pageboy

/// A bar with static buttons and line indicator.
///
/// Akin to Instagram notification screen etc.
internal class TabmanDistributedButtonBar: TabmanStaticButtonBar {

    //
    // MARK: Lifecycle
    //
    
    override func defaultIndicatorStyle() -> TabmanIndicator.Style {
        return .line
    }
    
    override func indicatorTransitionType() -> TabmanIndicatorTransition.Type? {
        return TabmanScrollingBarIndicatorTransition.self
    }
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    override func constructTabBar(items: [TabmanBarItem]) {
        super.constructTabBar(items: items)
        
        self.addBarButtons(toView: self.contentView, items: items) { (button, previousButton) in
            self.buttons.append(button)
            
            if let previousButton = previousButton {
                button.autoMatch(.width, to: .width, of: previousButton)
            }
        }
    }
}
