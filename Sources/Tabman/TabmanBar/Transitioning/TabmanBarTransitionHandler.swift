//
//  TabmanBarTransitionHandler.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

internal class TabmanBarTransitionHandler: Any {
    
    private lazy var scrollingIndicatorTransition = TabmanScrollingBarIndicatorTransition()
    private lazy var staticIndicatorTransition = TabmanStaticBarIndicatorTransition()
    
    func indicatorTransition(forBar bar: TabmanBar) -> TabmanIndicatorTransition {
        
        if let scrollingBar = bar as? TabmanScrollingButtonBar {
            self.scrollingIndicatorTransition.tabmanBar = scrollingBar
            return self.scrollingIndicatorTransition
        }
        
        self.staticIndicatorTransition.tabmanBar = bar
        return self.staticIndicatorTransition
    }
}
