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

open class TabmanBar: UIView, TabmanBarLifecycle {
    
    //
    // MARK: Types
    //
    
    /// The style of the bar.
    ///
    /// - bar: A simple horizontal bar only.
    /// - buttonBar: A scrolling horizontal bar with text buttons for each page index.
    /// - blockTabBar: A tab bar with sliding block style indicator behind tabs.
    /// - custom: A custom defined TabmanBar type.
    public enum Style {
        case bar
        case buttonBar
        case scrollingButtonBar
        case custom(type: TabmanBar.Type)
    }
    
    //
    // MARK: Properties
    //
    
    // Private
    
    internal var items: [TabmanBarItem]?
    
    internal private(set) var currentPosition: CGFloat = 0.0
    internal var fadeGradientLayer: CAGradientLayer?
    
    internal var indicatorLeftMargin: NSLayoutConstraint?
    internal var indicatorWidth: NSLayoutConstraint?
    internal var indicatorIsProgressive: Bool = TabmanBar.Appearance.defaultAppearance.indicator.isProgressive ?? false
    internal var indicatorBounces: Bool = TabmanBar.Appearance.defaultAppearance.indicator.bounces ?? false
    
    internal var indicatorMaskView: UIView = {
        let maskView = UIView()
        maskView.backgroundColor = .black
        return maskView
    }()
    
    internal weak var transitionHandler: TabmanBarTransitionHandler?
    
    /// The object that acts as a delegate to the bar.
    internal var delegate: TabmanBarDelegate?
    
    // Public
    
    /// The object that acts as a data source to the bar.
    public var dataSource: TabmanBarDataSource? {
        didSet {
            self.reloadData()
        }
    }
    
    /// Appearance configuration for the bar.
    public var appearance: Appearance = .defaultAppearance {
        didSet {
            self.update(forAppearance: appearance)
        }
    }
    
    /// Background view of the bar.
    public private(set) var backgroundView: TabmanBarBackgroundView = TabmanBarBackgroundView(forAutoLayout: ())
    /// The content view for the bar.
    public private(set) var contentView = UIView(forAutoLayout: ())
    
    /// Indicator for the bar.
    public private(set) var indicator: TabmanIndicator? {
        didSet {
            indicator?.delegate = self
            self.clear(indicator: oldValue)
        }
    }
    /// Preferred style for the indicator. 
    /// Bar conforms at own discretion via usePreferredIndicatorStyle()
    public var preferredIndicatorStyle: TabmanIndicator.Style? {
        didSet {
            self.updateIndicator(forPreferredStyle: preferredIndicatorStyle)
        }
    }
    
    /// The limit that the bar has for the number of items it can display.
    public var itemCountLimit: Int? {
        get {
            return nil
        }
    }
    
    //
    // MARK: Init
    //
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initTabBar(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initTabBar(coder: nil)
    }
    
    private func initTabBar(coder aDecoder: NSCoder?) {
        self.addSubview(backgroundView)
        backgroundView.autoPinEdgesToSuperviewEdges()
        
        self.addSubview(contentView)
        contentView.autoPinEdgesToSuperviewEdges()
        
        self.indicator = self.create(indicatorForStyle: self.defaultIndicatorStyle())
    }
    
    //
    // MARK: Lifecycle
    //
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.fadeGradientLayer?.frame = self.bounds
        
        // refresh intrinsic size for indicator
        self.indicator?.invalidateIntrinsicContentSize()
    }
    
    open override func addSubview(_ view: UIView) {
        if view !== self.backgroundView && view !== self.contentView {
            fatalError("Please add subviews to the contentView rather than directly onto the TabmanBar")
        }
        super.addSubview(view)
    }
    
    /// The default indicator style for the bar.
    ///
    /// - Returns: The default indicator style.
    open func defaultIndicatorStyle() -> TabmanIndicator.Style {
        print("indicatorStyle() returning default. This should be overridden in subclass")
        return .none
    }
    
    /// Whether the bar should use preferredIndicatorStyle if available
    ///
    /// - Returns: Whether to use preferredIndicatorStyle
    open func usePreferredIndicatorStyle() -> Bool {
        return true
    }
    
    //
    // MARK: Data
    //
    
    /// Reload and reconstruct the contents of the bar.
    public func reloadData() {
        self.items = self.dataSource?.items(forBar: self)
        self.clearAndConstructBar()
    }
    
    //
    // MARK: Bar
    //
    
    /// Reconstruct the bar for a new style or data set.
    private func clearAndConstructBar() {
        self.indicatorWidth?.isActive = false
        self.indicatorLeftMargin?.isActive = false
        self.clearBar()

        guard let items = self.items else { return } // no items yet
        
        self.constructTabBar(items: items)
        if let indicator = self.indicator {
            self.addIndicatorToBar(indicator: indicator)
        }
        
        self.update(forAppearance: self.appearance)
        self.updateForCurrentPosition()
    }
    
    /// Remove all components and subviews from the bar.
    internal func clearBar() {
        self.contentView.removeAllSubviews()
    }
    
    //
    // MARK: Indicator
    //
    
    /// Remove a scroll indicator from the bar.
    internal func clear(indicator: TabmanIndicator?) {
        self.indicatorMaskView.frame = .zero // reset mask
        indicator?.removeFromSuperview()
        indicator?.removeConstraints(indicator?.constraints ?? [])
    }
    
    /// Create a new indicator for a style.
    ///
    /// - Parameter style: The style.
    /// - Returns: The new indicator.
    internal func create(indicatorForStyle style: TabmanIndicator.Style) -> TabmanIndicator? {
        if let indicatorType = style.rawType {
            return indicatorType.init()
        }
        return nil
    }
    
    /// Update the current indicator for a preferred style.
    ///
    /// - Parameter preferredStyle: The new preferred style.
    private func updateIndicator(forPreferredStyle preferredStyle: TabmanIndicator.Style?) {
        guard let preferredIndicatorStyle = self.preferredIndicatorStyle else {
            
            // restore default if no preferred style
            self.indicator = self.create(indicatorForStyle: self.defaultIndicatorStyle())
            guard self.indicator != nil else { return }
            self.addIndicatorToBar(indicator: indicator!)
            self.updateForCurrentPosition()
            
            return
        }
        guard self.usePreferredIndicatorStyle() else { return }
        
        // return nil if same type as current indicator
        if let indicator = self.indicator {
            guard type(of: indicator) != preferredStyle?.rawType else {
                return
            }
        }
        
        // Create new preferred style indicator.
        self.indicator = self.create(indicatorForStyle: preferredIndicatorStyle)
        guard self.indicator != nil else { return }
        
        self.addIndicatorToBar(indicator: indicator!)
        self.updateForCurrentPosition()
    }
    
    //
    // MARK: Positioning
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
    
    internal func updateForCurrentPosition() {
        guard let items = self.items else {
            return
        }
        
        self.update(forPosition: self.currentPosition,
                    direction: .neutral,
                    minimumIndex: 0,
                    maximumIndex: items.count - 1)
    }
    
    //
    // MARK: TabmanBarLifecycle
    //
    
    open func constructTabBar(items: [TabmanBarItem]) {
        // Override in subclass
    }
    
    public func addIndicatorToBar(indicator: TabmanIndicator) {
        // Override in subclass
    }
    
    open func update(forPosition position: CGFloat,
                         direction: PageboyViewController.NavigationDirection,
                         minimumIndex: Int,
                         maximumIndex: Int) {
        guard self.indicator != nil else { return }
        
        let indicatorTransition = self.transitionHandler?.indicatorTransition(forBar: self)
        indicatorTransition?.transition(withPosition: position, direction: direction,
                                        minimumIndex: minimumIndex, maximumIndex: maximumIndex)
        
        let indicatorType = type(of: self.indicator!)
        let indicatorStyle = TabmanIndicator.Style.fromType(indicatorType)
        let itemTransition = self.transitionHandler?.itemTransition(forBar: self, indicatorStyle: indicatorStyle)
        itemTransition?.transition(withPosition: position, direction: direction,
                                   minimumIndex: minimumIndex, maximumIndex: maximumIndex)
    }
    
    open func update(forAppearance appearance: Appearance) {
        self.preferredIndicatorStyle = appearance.indicator.preferredStyle
        
        if let backgroundStyle = appearance.style.background {
            self.backgroundView.backgroundStyle = backgroundStyle
        }
        
        if let indicatorIsProgressive = appearance.indicator.isProgressive {
            self.indicatorIsProgressive = indicatorIsProgressive
            UIView.animate(withDuration: 0.3, animations: {
                self.updateForCurrentPosition()
            })
        }

        if let indicatorBounces = appearance.indicator.bounces {
            self.indicatorBounces = indicatorBounces
        }
        
        if let indicatorColor = appearance.indicator.color {
            self.indicator?.tintColor = indicatorColor
        }
        
        self.updateEdgeFade(visible: appearance.style.showEdgeFade ?? false)
    }
}

extension TabmanBar: TabmanIndicatorDelegate {
    
    func indicator(requiresLayoutInvalidation indicator: TabmanIndicator) {
        self.invalidateIntrinsicContentSize()
        self.setNeedsLayout()
        self.layoutIfNeeded()
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
            self.contentView.layer.mask = gradientLayer
            self.fadeGradientLayer = gradientLayer
            
        } else {
            self.contentView.layer.mask = nil
            self.fadeGradientLayer = nil
        }
    }
}

internal extension TabmanIndicator.Style {
    
    var rawType: TabmanIndicator.Type? {
        switch self {
        case .line:
            return TabmanLineIndicator.self
        case .dot:
            return TabmanDotIndicator.self
        case .block:
            return TabmanBlockIndicator.self
        case .custom(let type):
            return type
        case .none:
            return nil
        }
    }
}
