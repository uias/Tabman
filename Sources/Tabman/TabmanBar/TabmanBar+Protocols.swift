//
//  TabmanBarProtocols.swift
//  Tabman
//
//  Created by Merrick Sapsford on 15/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Pageboy

public protocol TabmanBarDataSource {
    
    /// The items to display in a bar.
    ///
    /// - Parameter bar: The bar.
    /// - Returns: Items to display in the tab bar.
    func items(forBar bar: TabmanBar) -> [TabmanBarItem]?
}

internal protocol TabmanBarDelegate {
    
    /// The bar did select an item at an index.
    ///
    /// - Parameters:
    ///   - bar: The bar.
    ///   - index: The selected index.
    func bar(_ bar: TabmanBar, didSelectItemAtIndex index: Int)
}

/// Lifecycle functions of TabmanBar
public protocol TabmanBarLifecycle: TabmanAppearanceUpdateable {
    
    /// Construct the contents of the tab bar for the current style and given items.
    ///
    /// - Parameter items: The items to display.
    func constructTabBar(items: [TabmanBarItem])
    
    func addIndicatorToBar(indicator: TabmanIndicator)
    
    /// Update the tab bar for a positional update.
    ///
    /// - Parameters:
    ///   - position: The new position.
    ///   - direction: The direction of travel.
    ///   - minimumIndex: The minimum possible index.
    ///   - maximumIndex: The maximum possible index.
    func update(forPosition position: CGFloat,
                direction: PageboyViewController.NavigationDirection,
                minimumIndex: Int,
                maximumIndex: Int)
}
