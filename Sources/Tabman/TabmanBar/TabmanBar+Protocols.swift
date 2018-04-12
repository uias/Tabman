//
//  TabmanBarProtocols.swift
//  Tabman
//
//  Created by Merrick Sapsford on 15/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation
import Pageboy

public protocol TabmanBarDataSource: class {
    
    /// The items to display in a bar.
    ///
    /// - Parameter bar: The bar.
    /// - Returns: Items to display in the tab bar.
    func items(for bar: TabmanBar) -> [TabmanBar.Item]?
}

internal protocol TabmanBarResponder: class {
    
    /// Control if the bar should allow the given item to be selected.
    ///
    /// - Parameters:
    ///   - bar: The bar.
    ///   - index: The item index.
    func bar(_ bar: TabmanBar, shouldSelectItemAt index: Int) -> Bool
    
    /// The bar did select an item at an index.
    ///
    /// - Parameters:
    ///   - bar: The bar.
    ///   - index: The selected index.
    ///   - completion: Completion handler for action.
    func bar(_ bar: TabmanBar,
             didSelectItemAt index: Int,
             completion: (() -> Void)?)
}

/// Lifecycle functions of TabmanBar
public protocol TabmanBarLifecycle: TabmanAppearanceUpdateable {
    
    /// Construct the contents of the tab bar for the current style and given items.
    ///
    /// - Parameter contentView: The view to construct the bar in.
    /// - Parameter items: The items to display.
    func construct(in contentView: UIView,
                   for items: [TabmanBar.Item])
    
    /// Add the indicator to the bar.
    ///
    /// - Parameter indicator: The indicator to add.
    /// - Parameter contentView: The view to construct the bar in.
    func add(indicator: TabmanIndicator, to contentView: UIView)
    
    /// Update the tab bar for a positional update.
    ///
    /// - Parameters:
    ///   - position: The new position.
    ///   - direction: The direction of travel.
    ///   - indexRange: The range of available indexes.
    ///   - bounds: The available bounds in the bar.
    func update(forPosition position: CGFloat,
                direction: PageboyViewController.NavigationDirection,
                indexRange: Range<Int>,
                bounds: CGRect)
}
