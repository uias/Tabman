//
//  Bar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 28/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public protocol BarDataSource: class {
    
    func barItem(for tabViewController: TabmanViewController, at index: Int) -> BarItem
}

public protocol BarDelegate: class {
    
    func bar(_ bar: Bar,
             didRequestScrollToPageAt index: Int)
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
    ///   - viewController: View Controller ot use for reloading.
    ///   - indexes: The indexes to reload.
    ///   - context: The context for the reload.
    func reloadData(for viewController: TabmanViewController,
                    at indexes: ClosedRange<Int>,
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
