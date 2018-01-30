//
//  TabmanBarTransitionHandler.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// Store for getting bar/indicator relevant transitions.
internal class TabmanBarTransitionStore: Any {
    
    //
    // MARK: Properties
    //

    private var transitions: [Int: TabmanTransition]
    
    //
    // MARK: Init
    //
    
    init() {
        
        // initialize available transitions
        let scrollingIndicatorTransition = TabmanScrollingBarIndicatorTransition()
        let staticIndicatorTransition = TabmanStaticBarIndicatorTransition()
        let itemColorTransition = TabmanItemColorCrossfadeTransition()
        let itemMaskTransition = TabmanItemMaskTransition()
        
        // create transitions hashmap
        var transitions: [Int: TabmanTransition] = [:]
        transitions[scrollingIndicatorTransition.hashValue] = scrollingIndicatorTransition
        transitions[staticIndicatorTransition.hashValue] = staticIndicatorTransition
        transitions[itemColorTransition.hashValue] = itemColorTransition
        transitions[itemMaskTransition.hashValue] = itemMaskTransition
        
        self.transitions = transitions
    }
    
    //
    // MARK: Transitions
    //
    
    /// Get the transition for the indicator of a particular bar.
    ///
    /// - Parameter bar: The bar.
    /// - Returns: The relevant transition.
    func indicatorTransition(forBar bar: TabmanBar) -> TabmanIndicatorTransition? {
        guard let transitionType = bar.indicatorTransitionType() else {
            return nil
        }
        
        let hash = String(describing: transitionType).hashValue
        guard let transition = self.transitions[hash] as? TabmanIndicatorTransition else {
            return nil
        }
        
        transition.tabmanBar = bar
        return transition
    }
    
    /// Get the relevant transition for bar items when using a particular indicator style.
    ///
    /// - Parameters:
    ///   - bar: The bar that the indicator is part of.
    ///   - indicatorStyle: The indicator style.
    /// - Returns: The item transition.
    func itemTransition(forBar bar: TabmanBar, indicator: TabmanIndicator) -> TabmanItemTransition? {
        guard let transitionType = indicator.itemTransitionType() else {
            return nil
        }
        
        let hash = String(describing: transitionType).hashValue
        guard let transition = self.transitions[hash] as? TabmanItemTransition else {
            return nil
        }
        
        transition.tabmanBar = bar
        return transition
    }
}
