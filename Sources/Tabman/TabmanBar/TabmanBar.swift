//
//  TabmanBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout
import Pageboy

public protocol TabmanBarDataSource {
    
    /// The items to display in the tab bar.
    ///
    /// - Parameter tabBar: The tab bar.
    /// - Returns: Items to display in the tab bar.
    func items(forTabBar tabBar: TabmanBar) -> [TabmanBarItem]?
}

public protocol TabmanBarDelegate {
    
    /// The tab bar did select a tab at an index.
    ///
    /// - Parameters:
    ///   - tabBar: The tab bar.
    ///   - index: The selected index.
    func tabBar(_ tabBar: TabmanBar, didSelectTabAtIndex index: Int)
}

public class TabmanBar: UIView {
    
    //
    // MARK: Properties
    //
    
    // Private
    
    internal var items: [TabmanBarItem]?
    internal var containerView = UIView(forAutoLayout: ())
    internal private(set) var currentPosition: CGFloat = 0.0
    internal var fadeGradientLayer: CAGradientLayer?
    
    // Public
    
    /// The object that acts as a data source to the tab bar.
    public var dataSource: TabmanBarDataSource? {
        didSet {
            self.reloadData()
        }
    }
    
    /// The object that acts as a delegate to the tab bar.
    public var delegate: TabmanBarDelegate?
    
    /// Appearance configuration for the tab bar.
    public var appearance: AppearanceConfig = .defaultAppearance {
        didSet {
            self.update(forAppearance: appearance)
        }
    }
    
    /// Background view of the tab bar.
    public private(set) var backgroundView: TabmanBarBackgroundView = TabmanBarBackgroundView(forAutoLayout: ())
    
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
        self.addSubview(backgroundView)
        backgroundView.autoPinEdgesToSuperviewEdges()
        
        self.addSubview(containerView)
        containerView.autoPinEdgesToSuperviewEdges()
    }
    
    //
    // MARK: Lifecycle
    //
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.fadeGradientLayer?.frame = self.bounds
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
        self.update(forAppearance: self.appearance)
    }
    
    //
    // MARK: TabBar content
    //
    
    /// Remove all components and subviews from the tab bar.
    internal func clearTabBar() {
        self.containerView.removeAllSubviews()
    }
    
    /// Construct the contents of the tab bar for the current style and given items.
    ///
    /// - Parameter items: The items to display.
    internal func constructTabBar(items: [TabmanBarItem]) {
        
    }
    
    //
    // MARK: Updating
    //
    
    internal func updatePosition(_ position: CGFloat,
                                 direction: PageboyViewController.NavigationDirection) {
        guard let items = self.items else {
            return
        }
        
        self.layoutIfNeeded()
        self.currentPosition = position
        self.update(forPosition: position,
                    direction: direction,
                    minimumIndex: 0, maximumIndex: items.count - 1)
    }
    
    /// Update the tab bar for a positional update.
    ///
    /// - Parameters:
    ///   - position: The new position.
    ///   - direction: The direction of travel.
    ///   - minimumIndex: The minimum possible index.
    ///   - maximumIndex: The maximum possible index.
    internal func update(forPosition position: CGFloat,
                         direction: PageboyViewController.NavigationDirection,
                         minimumIndex: Int,
                         maximumIndex: Int) {
        // Abstract function
    }
    
    /// Update the appearance of the tab bar for a new configuration.
    ///
    /// - Parameter appearance: The new configuration.
    internal func update(forAppearance appearance: AppearanceConfig) {
        
        if let backgroundStyle = appearance.backgroundStyle {
            self.backgroundView.backgroundStyle = backgroundStyle
        }
        
        self.updateEdgeFade(visible: appearance.showEdgeFade ?? false)
    }
}

// MARK: - Bar appearance configuration
internal extension TabmanBar {
    
    func updateEdgeFade(visible: Bool) {
        if visible {
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.locations = [0.02, 0.05, 0.95, 0.98]
            self.containerView.layer.mask = gradientLayer
            self.fadeGradientLayer = gradientLayer
            
        } else {
            self.containerView.layer.mask = nil
            self.fadeGradientLayer = nil
        }
    }
}

internal extension TabmanBarConfig.Style {
    
    var rawType: TabmanBar.Type? {
        switch self {
            
        case .buttonBar:
            return TabmanButtonBar.self
            
        case .progressiveBar:
            return TabmanProgressiveBar.self
            
        default:()
        }
        return nil
    }
    
}
