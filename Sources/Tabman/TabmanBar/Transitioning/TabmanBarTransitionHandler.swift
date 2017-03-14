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
    
    func indicatorTransition(forBar bar: TabmanBar) -> TabmanIndicatorTransition? {
        
        if bar is TabmanScrollingButtonBar {
            
            self.scrollingIndicatorTransition.tabmanBar = bar
            return self.scrollingIndicatorTransition
            
        } else if bar is TabmanPlainBar || bar is TabmanButtonBar {
            
            self.staticIndicatorTransition.tabmanBar = bar
            return self.staticIndicatorTransition
        }
        
        return nil
    }
    
    func itemTransition(forBar bar: TabmanBar, indicator: TabmanIndicator) -> TabmanItemTransition? {
        return nil
    }
}
