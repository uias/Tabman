//
//  TabmanBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

public protocol TabmanBarDelegate: class {
    
    /// Whether a bar should select an item at an index.
    ///
    /// - Parameters:
    ///   - index: The proposed selection index.
    /// - Returns: Whether the index should be selected.
    func bar(shouldSelectItemAt index: Int) -> Bool
}

/// A bar that displays the current page status of a TabmanViewController.
open class TabmanBar: UIView, TabmanBarLifecycle {
    
    // MARK: Types
    
    /// The height for the bar.
    ///
    /// - auto: Autosize the bar according to its contents.
    /// - explicit: Explicit value for the bar height.
    public enum Height {
        case auto
        case explicit(value: CGFloat)
    }
    
    // MARK: Properties
    
    /// The items that are displayed in the bar.
    internal var items: [TabmanBar.Item]? {
        didSet {
            self.isHidden = (items?.count ?? 0) == 0
        }
    }
    
    internal private(set) var currentPosition: CGFloat = 0.0
    internal weak var transitionStore: TabmanBarTransitionStore?
    internal lazy var behaviorEngine = BarBehaviorEngine(for: self)

    /// The object that acts as a responder to the bar.
    internal weak var responder: TabmanBarResponder?
    /// The object that acts as a data source to the bar.
    public weak var dataSource: TabmanBarDataSource? {
        didSet {
            self.reloadData()
        }
    }
    
    /// Appearance configuration for the bar.
    public var appearance: Appearance = .defaultAppearance {
        didSet {
            self.updateCore(forAppearance: appearance)
        }
    }
    
    /// The height for the bar. Default: .auto
    public var height: Height = .auto {
        didSet {
            switch height {
            case let .explicit(value) where value == 0:
                removeAllSubviews()
            default: break
            }
            
            self.invalidateIntrinsicContentSize()
            self.superview?.setNeedsLayout()
            self.superview?.layoutIfNeeded()
        }
    }
    open override var intrinsicContentSize: CGSize {
        var autoSize = super.intrinsicContentSize
        switch self.height {
    
        case .explicit(let height):
            autoSize.height = height
            return autoSize
            
        default:
            return autoSize
        }
    }
    
    /// Background view of the bar.
    public private(set) var backgroundView: BackgroundView = BackgroundView()
    /// The content view for the bar.
    public private(set) var contentView = UIView()
    /// The bottom separator view for the bar.
    internal private(set) var bottomSeparator = SeparatorView()
    
    /// Indicator for the bar.
    public internal(set) var indicator: TabmanIndicator? {
        didSet {
            indicator?.delegate = self
            self.clear(indicator: oldValue)
        }
    }
    /// Mask view used for indicator.
    internal var indicatorMaskView: UIView = {
        let maskView = UIView()
        maskView.backgroundColor = .black
        return maskView
    }()
    internal var indicatorLeftMargin: NSLayoutConstraint?
    internal var indicatorWidth: NSLayoutConstraint?
    internal var indicatorIsProgressive: Bool = TabmanBar.Appearance.defaultAppearance.indicator.isProgressive ?? false {
        didSet {
            guard indicatorIsProgressive != oldValue else {
                return
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.updateForCurrentPosition()
            })
        }
    }
    internal var indicatorBounces: Bool = TabmanBar.Appearance.defaultAppearance.indicator.bounces ?? false
    internal var indicatorCompresses: Bool = TabmanBar.Appearance.defaultAppearance.indicator.compresses ?? false
    /// Preferred style for the indicator. 
    /// Bar conforms at own discretion via usePreferredIndicatorStyle()
    public var preferredIndicatorStyle: TabmanIndicator.Style? {
        didSet {
            self.updateIndicator(forPreferredStyle: preferredIndicatorStyle)
        }
    }
    
    /// The limit that the bar has for the number of items it can display.
    public var itemCountLimit: Int? {
        return nil
    }
    
    // MARK: Init
    
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
        backgroundView.pinToSuperviewEdges()
        
        bottomSeparator.addAsSubview(to: self)
        
        self.addSubview(contentView)
        if #available(iOS 11, *) {
            contentView.pinToSafeArea(layoutGuide: safeAreaLayoutGuide)
        } else {
            contentView.pinToSuperviewEdges()
        }
        
        self.indicator = self.create(indicatorForStyle: self.defaultIndicatorStyle())
    }
    
    // MARK: Lifecycle
    
    open override func layoutSubviews() {
        super.layoutSubviews()
                
        // refresh intrinsic size for indicator
        self.indicator?.invalidateIntrinsicContentSize()
    }
    
    open override func addSubview(_ view: UIView) {
        if view !== self.backgroundView &&
            view !== self.contentView &&
            view !== self.bottomSeparator {
            fatalError("Please add subviews to the contentView rather than directly onto the TabmanBar")
        }
        super.addSubview(view)
    }
    
    /// The default indicator style for the bar.
    ///
    /// - Returns: The default indicator style.
    open func defaultIndicatorStyle() -> TabmanIndicator.Style {
        print("indicatorStyle() returning default. This should be overridden in subclass")
        return .clear
    }
    
    /// Whether the bar should use preferredIndicatorStyle if available
    ///
    /// - Returns: Whether to use preferredIndicatorStyle
    open func usePreferredIndicatorStyle() -> Bool {
        return true
    }
    
    /// The type of transition to use for the indicator (Internal use only).
    ///
    /// - Returns: The transition type.
    internal func indicatorTransitionType() -> TabmanIndicatorTransition.Type? {
        return nil
    }
    
    // MARK: Data
    
    /// Reload and reconstruct the contents of the bar.
    public func reloadData() {
        self.items = self.dataSource?.items(for: self)
        self.clearAndConstructBar()
    }
    
    // MARK: Updating
    
    internal func updatePosition(_ position: CGFloat,
                                 direction: PageboyViewController.NavigationDirection,
                                 bounds: CGRect? = nil) {
        guard let items = self.items else {
            return
        }
        let bounds = bounds ?? self.bounds
        
        self.layoutIfNeeded()
        self.currentPosition = position
        
        self.update(forPosition: position,
                    direction: direction,
                    indexRange: 0 ..< items.count - 1,
                    bounds: bounds)
        behaviorEngine.update(activation: .onPositionChange)
    }
    
    internal func updateForCurrentPosition(bounds: CGRect? = nil) {
        self.updatePosition(self.currentPosition,
                            direction: .neutral,
                            bounds: bounds)
    }
    
    // MARK: TabmanBarLifecycle
    
    open func construct(in contentView: UIView,
                        for items: [TabmanBar.Item]) {
    }
    
    open func add(indicator: TabmanIndicator, to contentView: UIView) {
        
    }
    
    open func update(forPosition position: CGFloat,
                     direction: PageboyViewController.NavigationDirection,
                     indexRange: Range<Int>,
                     bounds: CGRect) {
        guard self.indicator != nil else {
            return
        }
        
        let indicatorTransition = self.transitionStore?.indicatorTransition(forBar: self)
        indicatorTransition?.transition(withPosition: position,
                                        direction: direction,
                                        indexRange: indexRange,
                                        bounds: bounds)
        
        let itemTransition = self.transitionStore?.itemTransition(forBar: self, indicator: self.indicator!)
        itemTransition?.transition(withPosition: position,
                                   direction: direction,
                                   indexRange: indexRange,
                                   bounds: bounds)
    }
    
    /// Appearance updates that are core to TabmanBar and must always be evaluated
    ///
    /// - Parameter appearance: The appearance config
    internal func updateCore(forAppearance appearance: Appearance) {
        let defaultAppearance = Appearance.defaultAppearance
        
        self.preferredIndicatorStyle = appearance.indicator.preferredStyle
        
        let backgroundStyle = appearance.style.background ?? defaultAppearance.style.background!
        self.backgroundView.style = backgroundStyle
        
        let height: Height
        let hideWhenSingleItem = appearance.state.shouldHideWhenSingleItem ?? defaultAppearance.state.shouldHideWhenSingleItem!
        if hideWhenSingleItem && items?.count ?? 0 <= 1 {
            height = .explicit(value: 0)
        } else {
            height = appearance.layout.height ?? .auto
        }
        self.height = height
        
        let bottomSeparatorColor = appearance.style.bottomSeparatorColor ?? defaultAppearance.style.bottomSeparatorColor!
        self.bottomSeparator.color = bottomSeparatorColor
        let bottomSeparatorEdgeInsets = appearance.layout.bottomSeparatorEdgeInsets ?? defaultAppearance.layout.bottomSeparatorEdgeInsets!
        self.bottomSeparator.edgeInsets = bottomSeparatorEdgeInsets
        
        self.update(forAppearance: appearance,
                    defaultAppearance: defaultAppearance)
    }
    
    open func update(forAppearance appearance: Appearance,
                     defaultAppearance: Appearance) {
        
        let indicatorIsProgressive = appearance.indicator.isProgressive ?? defaultAppearance.indicator.isProgressive!
        self.indicatorIsProgressive = indicatorIsProgressive ? self.indicator?.isProgressiveCapable ?? false : false

        let indicatorBounces = appearance.indicator.bounces ?? defaultAppearance.indicator.bounces!
        self.indicatorBounces = indicatorBounces
        
        let indicatorCompresses = appearance.indicator.compresses ?? defaultAppearance.indicator.compresses!
        self.indicatorCompresses = indicatorBounces ? false : indicatorCompresses // only allow compression if bouncing disabled
        
        let indicatorColor = appearance.indicator.color
        self.indicator?.tintColor = indicatorColor ?? defaultAppearance.indicator.color!
        
        let indicatorUsesRoundedCorners = appearance.indicator.useRoundedCorners
        let lineIndicator = self.indicator as? TabmanLineIndicator
        lineIndicator?.useRoundedCorners = indicatorUsesRoundedCorners ?? defaultAppearance.indicator.useRoundedCorners!
        
        let indicatorWeight = appearance.indicator.lineWeight ?? defaultAppearance.indicator.lineWeight!
        if let lineIndicator = self.indicator as? TabmanLineIndicator {
            lineIndicator.weight = indicatorWeight
        }
    }
    
    // MARK: Actions
    
    /// Inform the TabmanViewController that an item in the bar was selected.
    ///
    /// - Parameter index: The index of the selected item.
    open func itemSelected(at index: Int) {
        responder?.bar(self, didSelectItemAt: index)
    }
}

extension TabmanBar: TabmanIndicatorDelegate {
    
    func indicator(requiresLayoutInvalidation indicator: TabmanIndicator) {
        self.invalidateIntrinsicContentSize()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}

internal extension TabmanIndicator.Style {
    
    var rawType: TabmanIndicator.Type? {
        switch self {
        case .line:
            return TabmanLineIndicator.self
        case .dot:
            return TabmanDotIndicator.self
        case .chevron:
            return TabmanChevronIndicator.self
        case .custom(let type):
            return type
        case .clear:
            return TabmanClearIndicator.self
        }
    }
}
