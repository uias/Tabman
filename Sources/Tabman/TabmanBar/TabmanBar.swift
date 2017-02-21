//
//  TabmanBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout

public protocol TabmanBarDataSource {
    
    func items(forTabBar tabBar: TabmanBar) -> [TabmanBarItem]?
}

public class TabmanBar: UIView {
    
    //
    // MARK: Types
    //
    
    public enum Style {
        case buttonBar
        case progressiveBar
        case segmented
    }
    
    public enum Location {
        case top
        case bottom
    }
    
    //
    // MARK: Variables
    //
    
    internal var items: [TabmanBarItem]?
    internal var containerView = UIView(forAutoLayout: ())
    
    //
    // MARK: Properties
    //
    
    /// The object that acts as a data source to the tab bar.
    public var dataSource: TabmanBarDataSource? {
        didSet {
            self.reloadData()
        }
    }
    
    /// The current relative selected position of the tab bar.
    internal var position: CGFloat = 0.0 {
        didSet {
            guard let items = self.items else {
                return
            }
            
            self.update(forPosition: position,
                        minimumIndex: 0, maximumIndex: items.count - 1)
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 44.0)
    }
    
    //
    // MARK: Init
    //
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initTabBar()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initTabBar()
    }
    
    private func initTabBar() {
        
        self.addSubview(containerView)
        containerView.autoPinEdgesToSuperviewEdges()
    }
    
    //
    // MARK: Data
    //
    
    /// Reload and reconstruct the contents of the tab bar.
    public func reloadData() {
        self.items = self.dataSource?.items(forTabBar: self)
        self.clearAndConstructTabBar()
    }
    
    /// Reconstruct the tab bar for a new style or data set.
    private func clearAndConstructTabBar() {
        guard let items = self.items else { return } // no items yet
        
        self.clearTabBar()
        self.constructTabBar(items: items)
    }
    
    //
    // MARK: TabBar content
    //
    
    /// Remove all components and subviews from the tab bar.
    func clearTabBar() {
        self.containerView.removeAllSubviews()
    }
    
    /// Construct the contents of the tab bar for the current style and given items.
    ///
    /// - Parameter items: The items to display.
    func constructTabBar(items: [TabmanBarItem]) {
        
    }
    
    /// Update the tab bar for a positional update.
    ///
    /// - Parameters:
    ///   - position: The new position.
    ///   - minimumIndex: The minimum possible index.
    ///   - maximumIndex: The maximum possible index.
    func update(forPosition position: CGFloat, minimumIndex: Int, maximumIndex: Int) {
        
    }
}

internal extension TabmanBar.Style {
    
    var rawType: TabmanBar.Type? {
        switch self {
            
        case .buttonBar:
            return TabmanButtonBar.self
            
        default:()
        }
        return nil
    }
    
}
