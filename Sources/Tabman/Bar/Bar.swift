//
//  Bar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 28/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// Data source that provides bar with items.
public protocol BarDataSource: class {
    
    /// Provide a `BarItem` for an index in the bar.
    ///
    /// - Parameters:
    ///   - bar: The bar.
    ///   - index: Index of the item.
    /// - Returns: The BarItem.
    func barItem(for bar: Bar, at index: Int) -> BarItem
}

/// Delegate that provides bar with responses to user interaction.
public protocol BarDelegate: class {
    
    /// Bar requires scrolling to a new page following a user interaction.
    ///
    /// - Parameters:
    ///   - bar: The bar.
    ///   - index: The new index.
    func bar(_ bar: Bar,
             didRequestScrollTo index: Int)
}

/// Context for causing a reload of a bar.
///
/// - full: A full reload has taken place.
/// - insertion: A page insertion has taken place.
/// - deletion: A page deletion has taken place.
public enum BarReloadContext {
    case full
    case insertion
    case deletion
}

/// Semantic direction of an update to the bar.
///
/// - none: No direction.
/// - forward: A forward direction (increasing).
/// - reverse: A reverse direction (reversing).
public enum BarUpdateDirection {
    case none
    case forward
    case reverse
}

/// A conforming `UIView` that can display a page position for a TabmanViewController.
public protocol Bar: AnyObject where Self: UIView {
    
    /// Object that acts as a data source to the bar.
    var dataSource: BarDataSource? { get set }
    /// Object that acts as a delegate to the bar.
    var delegate: BarDelegate? { get set }
    
    /// Reload the data within the bar.
    ///
    /// - Parameters:
    ///   - indexes: The indexes to reload.
    ///   - context: The context for the reload.
    func reloadData(at indexes: ClosedRange<Int>,
                    context: BarReloadContext)
    
    
    /// Update the display in the bar for a particular page position.
    ///
    /// - Parameters:
    ///   - pagePosition: Position to display.
    ///   - capacity: The capacity of the bar.
    ///   - direction: Semantic direction of the update.
    ///   - shouldAnimate: Whether the bar should animate the update.
    func update(for pagePosition: CGFloat,
                capacity: Int,
                direction: BarUpdateDirection,
                shouldAnimate: Bool)
}
