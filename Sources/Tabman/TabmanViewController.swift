//
//  TabmanViewController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy
import AutoInsetter

/// Page view controller with a bar indicator component.
open class TabmanViewController: PageboyViewController, PageboyViewControllerDelegate {
    
    // MARK: Types
    
    /// Item for a TabmanBar.
    public typealias Item = TabmanBar.Item
    
    // MARK: Properties
    
    /// The internally managed Tabman bar.
    internal fileprivate(set) var tabmanBar: TabmanBar?
    /// The currently attached TabmanBar (if it exists).
    internal var attachedTabmanBar: TabmanBar?
    /// The view that is currently being used to embed the instance managed TabmanBar.
    internal var embeddingView: UIView?
    
    /// Returns the active bar, prefers attachedTabmanBar if available.
    internal var activeTabmanBar: TabmanBar? {
        if let attachedTabmanBar = self.attachedTabmanBar {
            return attachedTabmanBar
        }
        return tabmanBar
    }
    
    /// Configuration for the bar.
    /// Able to set items, appearance, location and style through this object.
    public var bar = TabmanBar.Config()
    
    /// Internal store for bar component transitions.
    internal var barTransitionStore = TabmanBarTransitionStore()
    
    /// Whether any UIScrollView in child view controllers should be
    /// automatically insetted to display below the TabmanBar.
    @available(*, deprecated: 1.2.0, message: "Use automaticallyAdjustsChildViewInsets")
    public var automaticallyAdjustsChildScrollViewInsets: Bool {
        set {
            automaticallyAdjustsChildViewInsets = newValue
        } get {
            return automaticallyAdjustsChildViewInsets
        }
    }
    /// Whether to automatically inset the contents of any child view controller.
    /// NOTE: Set this before setting a dataSource on the TabmanViewController.
    /// Defaults to true.
    public var automaticallyAdjustsChildViewInsets: Bool = true {
        didSet {
            guard viewIfLoaded != nil else {
                return
            }
            self.automaticallyAdjustsScrollViewInsets = !automaticallyAdjustsChildViewInsets
            autoInsetter.isEnabled = automaticallyAdjustsChildViewInsets
        }
    }
    internal let autoInsetter = AutoInsetter()
    
    // MARK: Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure for auto insetting
        self.automaticallyAdjustsScrollViewInsets = !automaticallyAdjustsChildViewInsets
        autoInsetter.isEnabled = automaticallyAdjustsChildViewInsets

        self.delegate = self
        self.bar.handler = self
        
        // add bar to view
        self.reloadBar(withStyle: self.bar.style)
        self.updateBar(withLocation: self.bar.location)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setNeedsChildAutoInsetUpdate()
        reloadBarWithCurrentPosition()
        
        let appearance = bar.appearance ?? .defaultAppearance
        let isBarExternal = embeddingView != nil || attachedTabmanBar != nil
        activeTabmanBar?.updateBackgroundEdgesForSystemAreasIfNeeded(for: bar.actualLocation,
                                                                     in: self,
                                                                     appearance: appearance,
                                                                     canExtend: !isBarExternal)
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let bounds = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)

        coordinator.animate(alongsideTransition: { (_) in
            self.activeTabmanBar?.updateForCurrentPosition(bounds: bounds)
        }, completion: nil)
    }
    
    // MARK: PageboyViewControllerDelegate
    
    private var isScrollingAnimated: Bool = false
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    willScrollToPageAt index: Int,
                                    direction: PageboyViewController.NavigationDirection,
                                    animated: Bool) {
        let viewController = dataSource?.viewController(for: self, at: index)
        setNeedsChildAutoInsetUpdate(for: viewController)
        
        if animated {
            isScrollingAnimated = true
            UIView.animate(withDuration: 0.3, animations: {
                self.activeTabmanBar?.updatePosition(CGFloat(index), direction: direction)
                self.activeTabmanBar?.layoutIfNeeded()
            })
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollToPageAt index: Int,
                                    direction: PageboyViewController.NavigationDirection,
                                    animated: Bool) {
        isScrollingAnimated = false
        self.updateBar(withPosition: CGFloat(index),
                       direction: direction)
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollTo position: CGPoint,
                                    direction: PageboyViewController.NavigationDirection,
                                    animated: Bool) {
        if !animated {
            self.updateBar(withPosition: pageboyViewController.navigationOrientation == .horizontal ? position.x : position.y,
                           direction: direction)
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didReloadWith currentViewController: UIViewController,
                                    currentPageIndex: PageboyViewController.PageIndex) {
        setNeedsChildAutoInsetUpdate(for: currentViewController)
    }
    
    // MARK: Positional Updates
    
    /// Update the bar with a new position.
    ///
    /// - Parameters:
    ///   - position: The new position.
    ///   - direction: The direction of travel.
    private func updateBar(withPosition position: CGFloat,
                           direction: PageboyViewController.NavigationDirection) {
        
        let viewControllersCount = self.pageCount ?? 0
        let barItemsCount = self.activeTabmanBar?.items?.count ?? 0
        let itemCountsAreEqual = viewControllersCount == barItemsCount
        
        if position >= CGFloat(barItemsCount - 1) && !itemCountsAreEqual {
            return
        }
        
        self.activeTabmanBar?.updatePosition(position, direction: direction)
    }
    
    /// Reload the bar with the currently active position.
    /// Called after any layout changes.
    private func reloadBarWithCurrentPosition() {
        guard let currentPosition = self.currentPosition, !isScrollingAnimated else {
            return
        }
        
        let position = self.navigationOrientation == .horizontal ? currentPosition.x : currentPosition.y
        updateBar(withPosition: position, direction: .neutral)
    }
}

// MARK: - Bar Reloading / Layout
internal extension TabmanViewController {
    
    /// Clear the existing bar from the screen.
    ///
    /// - Parameter bar: The bar to clear.
    func clearUpBar(_ bar: inout TabmanBar?) {
        bar?.removeFromSuperview()
        bar = nil
    }
    
    /// Reload the tab bar for a new style.
    ///
    /// - Parameter style: The new style.
    func reloadBar(withStyle style: TabmanBar.Style) {
        guard let barType = style.rawType else {
            return
        }
        
        // re create the tab bar with a new style
        let bar = barType.init()
        bar.transitionStore = self.barTransitionStore
        bar.dataSource = self
        bar.responder = self
        bar.behaviorEngine.activeBehaviors = self.bar.behaviors
        bar.isHidden = (bar.items?.count ?? 0) == 0 // hidden if no items
        if let appearance = self.bar.appearance {
            bar.appearance = appearance
        }

        self.tabmanBar = bar
    }
    
    /// Update the bar with a new screen location.
    ///
    /// - Parameter location: The new location.
    func updateBar(withLocation location: TabmanBar.Location) {
        guard self.embeddingView == nil else {
            self.embedBar(in: self.embeddingView!)
            return
        }
        
        guard let bar = self.tabmanBar else {
            return
        }
        guard bar.superview == nil || bar.superview === self.view else {
            return
        }
        
        // use style preferred location if no exact location specified.
        var location = location
        if location == .preferred {
            location = self.bar.style.preferredLocation
        }
        
        // ensure bar is always on top
        // Having to use CGFloat cast due to CGFloat.greatestFiniteMagnitude causing 
        // "zPosition should be within (-FLT_MAX, FLT_MAX) range" error.
        bar.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        
        bar.removeFromSuperview()
        self.view.addSubview(bar)
        
        // move tab bar to location
        switch location {
            
        case .top:
            bar.barAutoPinToTop(topLayoutGuide: self.topLayoutGuide)
        case .bottom:
            bar.barAutoPinToBotton(bottomLayoutGuide: self.bottomLayoutGuide)
            
        default:()
        }
        self.view.layoutIfNeeded()
        
        let position = self.navigationOrientation == .horizontal ? self.currentPosition?.x : self.currentPosition?.y
        bar.updatePosition(position ?? 0.0, direction: .neutral)
        
        setNeedsChildAutoInsetUpdate()
    }
}

// MARK: - TabmanBarDataSource, TabmanBarResponder
extension TabmanViewController: TabmanBarDataSource, TabmanBarResponder {
    
    public func items(for bar: TabmanBar) -> [Item]? {
        if let itemCountLimit = bar.itemCountLimit {
            guard self.bar.items?.count ?? 0 <= itemCountLimit else {
                print("TabmanBar Error:\nItems in bar.items exceed the available count for the current bar style: (\(itemCountLimit)).")
                print("Either reduce the number of items or use a different style. Escaping now.")
                return nil
            }
        }
        
        return self.bar.items
    }
    
    public func bar(_ bar: TabmanBar, shouldSelectItemAt index: Int) -> Bool {
        return self.bar.delegate?.bar(shouldSelectItemAt: index) ?? true
    }
    
    public func bar(_ bar: TabmanBar, didSelectItemAt index: Int) {
        self.scrollToPage(.at(index: index), animated: true)
    }
}

// MARK: - TabmanBarConfigHandler
extension TabmanViewController: TabmanBarConfigHandler {
    
    func config(_ config: TabmanBar.Config, didUpdate style: TabmanBar.Style) {
        guard self.attachedTabmanBar == nil else {
            return
        }
        
        self.clearUpBar(&self.tabmanBar)
        self.reloadBar(withStyle: style)
        self.updateBar(withLocation: config.location)
    }
    
    func config(_ config: TabmanBar.Config, didUpdate location: TabmanBar.Location) {
        guard self.attachedTabmanBar == nil else {
            return
        }

        self.updateBar(withLocation: location)
    }
    
    func config(_ config: TabmanBar.Config, didUpdate appearance: TabmanBar.Appearance) {
        self.activeTabmanBar?.appearance = appearance
    }
    
    func config(_ config: TabmanBar.Config, didUpdate items: [TabmanBar.Item]?) {
        activeTabmanBar?.reloadData()
        setNeedsChildAutoInsetUpdate()
    }
    
    func config(_ config: TabmanBar.Config, didUpdate behaviors: [TabmanBar.Behavior]?) {
        activeTabmanBar?.behaviorEngine.activeBehaviors = behaviors
        setNeedsChildAutoInsetUpdate()
    }
}
