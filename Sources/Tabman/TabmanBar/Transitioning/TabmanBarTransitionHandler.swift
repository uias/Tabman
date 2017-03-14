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
    
    private lazy var itemColorTransition = TabmanItemColorTransition()
    private lazy var itemMaskTransition = TabmanItemMaskTransition()
    
    func indicatorTransition(forBar bar: TabmanBar) -> TabmanIndicatorTransition? {
        
        if bar is TabmanScrollingButtonBar {
            
            self.scrollingIndicatorTransition.tabmanBar = bar
            return self.scrollingIndicatorTransition
            
        } else if bar is TabmanPlainBar || bar is TabmanStaticButtonBar {
            
            self.staticIndicatorTransition.tabmanBar = bar
            return self.staticIndicatorTransition
        }
        
        return nil
    }
    
    func itemTransition(forBar bar: TabmanBar, indicatorStyle: TabmanIndicator.Style) -> TabmanItemTransition? {
        switch indicatorStyle {

        case .block:
            self.itemMaskTransition.tabmanBar = bar
            return self.itemMaskTransition
            
        default:
            if bar is TabmanButtonBar {
                self.itemColorTransition.tabmanBar = bar
                return self.itemColorTransition
            }
        }
        
        return nil
    }
}
