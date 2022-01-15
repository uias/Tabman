//
//  TMBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 28/05/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

/// Data source to a `TMBar` that is primarily responsible for providing a bar with contents.
public protocol TMBarDataSource: AnyObject {
    
    /// Provide a `BarItem` for an index in the bar.
    ///
    /// - Parameters:
    ///   - bar: The bar.
    ///   - index: Index of the item.
    /// - Returns: The BarItem.
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable
}

/// Delegate to a `TMBar` that is primarily responsible for handling user interaction within the bar.
public protocol TMBarDelegate: AnyObject {
    
    /// Bar requires scrolling to a new page following a user interaction.
    ///
    /// - Parameters:
    ///   - bar: The bar.
    ///   - index: The new index.
    func bar(_ bar: TMBar,
             didRequestScrollTo index: Int)
}

/// Context for causing a reload of a bar.
///
/// - full: A full reload has taken place.
/// - insertion: A page insertion has taken place.
/// - deletion: A page deletion has taken place.
public enum TMBarReloadContext {
    case full
    case insertion
    case deletion
}

/// Semantic direction of an update to the bar.
///
/// - none: No direction.
/// - forward: A forward direction (increasing).
/// - reverse: A reverse direction (reversing).
public enum TMBarUpdateDirection {
    case none
    case forward
    case reverse
}

/// `BaseTMBar` is a base protocol of AnyObject to avoid Swift compiler error
/// :nodoc:
public protocol BaseTMBar: AnyObject { }

/// `TMBar` is a protocol that is constrained to `UIView` types. Conforming view types can be added to
/// and displayed in a `TabmanViewController`.
///
/// `TMBar` is expected to display a `TMBarItem` collection provided by a data source visually
/// in some form, and also respond to the current page position.
///
/// The default implementation of `TMBar` in Tabman is `TMBarView`.
public protocol TMBar: BaseTMBar where Self: UIView {
    
    /// Object that acts as a data source to the bar.
    var dataSource: TMBarDataSource? { get set }
    /// Object that acts as a delegate to the bar.
    var delegate: TMBarDelegate? { get set }
    
    /// Items that are currently displayed in the bar.
    var items: [TMBarItemable]? { get }
    
    /// Reload the data within the bar.
    ///
    /// - Parameters:
    ///   - indexes: The indexes to reload.
    ///   - context: The context for the reload.
    func reloadData(at indexes: ClosedRange<Int>,
                    context: TMBarReloadContext)
    
    /// Update the display in the bar for a particular page position.
    ///
    /// - Parameters:
    ///   - pagePosition: Position to display.
    ///   - capacity: The capacity of the bar.
    ///   - direction: Semantic direction of the update.
    ///   - shouldAnimate: Whether the bar should animate the update.
    func update(for position: CGFloat,
                capacity: Int,
                direction: TMBarUpdateDirection,
                animation: TMAnimation)
}
