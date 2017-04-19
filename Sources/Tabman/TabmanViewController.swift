//
//  TabmanViewController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Pageboy

/// Page view controller with a bar indicator component.
open class TabmanViewController: PageboyViewController, PageboyViewControllerDelegate {
    
    //
    // MARK: Properties
    //
    
    /// The instance managed Tabman bar.
    internal fileprivate(set) var tabmanBar: TabmanBar?
    /// Currently attached TabmanBar if it exists.
    internal var attachedTabmanBar: TabmanBar?
    /// The view that is currently being used to embed the instance managed TabmanBar.
    internal var embeddingView: UIView?
    
    /// Returns the active bar, prefers attachedTabmanBar if available.
    fileprivate var activeTabmanBar: TabmanBar? {
        if let attachedTabmanBar = self.attachedTabmanBar {
            return attachedTabmanBar
        }
        return tabmanBar
    }
    
    /// Configuration for the bar.
    /// Able to set items, appearance, location and style through this object.
    public lazy var bar = TabmanBarConfig()
    
    /// Internal store for bar component transitions.
    internal lazy var barTransitionStore = TabmanBarTransitionStore()
    
    //
    // MARK: Lifecycle
    //
    
    open override func loadView() {
        super.loadView()
        
        self.delegate = self
        self.bar.delegate = self
        
        // add bar to view
        self.reloadBar(withStyle: self.bar.style)
        self.updateBar(withLocation: self.bar.location)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.reloadRequiredBarInsets()
        self.insetChildViewControllerIfNeeded(self.currentViewController)
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let bounds = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)

        coordinator.animate(alongsideTransition: { (context) in
            self.activeTabmanBar?.updateForCurrentPosition(bounds: bounds)
        }, completion: nil)
    }
    
    //
    // MARK: PageboyViewControllerDelegate
    //
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      willScrollToPageAtIndex index: Int,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
        self.insetChildViewControllerIfNeeded(self.viewControllers?[index])
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.activeTabmanBar?.updatePosition(CGFloat(index), direction: direction)
                self.activeTabmanBar?.layoutIfNeeded()
            })
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didScrollToPageAtIndex index: Int,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
        self.updateBar(withPosition: CGFloat(index),
                       direction: direction)
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didScrollToPosition position: CGPoint,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
        if !animated {
            self.updateBar(withPosition: pageboyViewController.navigationOrientation == .horizontal ? position.x : position.y,
                           direction: direction)
        }
    }
    
    private func updateBar(withPosition position: CGFloat,
                           direction: PageboyViewController.NavigationDirection) {
        
        let viewControllersCount = self.viewControllers?.count ?? 0
        let barItemsCount = self.activeTabmanBar?.items?.count ?? 0
        let itemCountsAreEqual = viewControllersCount == barItemsCount
        
        if position >= CGFloat(barItemsCount - 1) && !itemCountsAreEqual { return }
        
        self.activeTabmanBar?.updatePosition(position, direction: direction)
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
        guard let barType = style.rawType else { return }
        
        // re create the tab bar with a new style
        let bar = barType.init()
        bar.transitionStore = self.barTransitionStore
        bar.dataSource = self
        bar.delegate = self
        bar.isHidden = (bar.items?.count ?? 0) == 0 // hidden if no items
        if let appearance = self.bar.appearance {
            bar.appearance = appearance
        }

        self.tabmanBar = bar
    }
    
    
    /// Update the bar with a new screen location.
    ///
    /// - Parameter location: The new location.
    func updateBar(withLocation location: TabmanBarConfig.Location) {
        guard self.embeddingView == nil else {
            self.embedBar(inView: self.embeddingView!)
            return
        }
        
        guard let bar = self.tabmanBar else { return }
        guard bar.superview == nil || bar.superview === self.view else { return }
        
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
        
        self.insetChildViewControllerIfNeeded(self.currentViewController)
    }
    
    /// Reload the required bar insets for the current bar.
    func reloadRequiredBarInsets() {
        self.bar.requiredContentInset = self.calculateRequiredBarInsets()
    }
    
    /// Calculate the required insets for the current bar.
    ///
    /// - Returns: The required bar insets
    private func calculateRequiredBarInsets() -> UIEdgeInsets {
        guard self.embeddingView == nil && self.attachedTabmanBar == nil else {
            return .zero
        }
        
        let frame = self.activeTabmanBar?.frame ?? .zero
        var insets = UIEdgeInsets.zero
        
        var location = self.bar.location
        if location == .preferred {
            location = self.bar.style.preferredLocation
        }
        
        switch location {
        case .bottom:
            insets.bottom = frame.size.height
            
        default:
            insets.top = frame.size.height
        }
        return insets
    }
}

// MARK: - Child view controller layout
internal extension TabmanViewController {
    
    func insetChildViewControllerIfNeeded(_ childViewController: UIViewController?) {
        guard let childViewController = childViewController else { return }
        
        // if a scroll view is found in child VC subviews inset by the required content inset.
        for subview in childViewController.view?.subviews ?? [] {
            if let scrollView = subview as? UIScrollView {
                var requiredContentInset = self.bar.requiredContentInset
                let currentContentInset = scrollView.contentInset
                requiredContentInset.top += self.topLayoutGuide.length
                
                // take into account any existing inset values and merge with content inset.
//                var topDiff = currentContentInset.top - requiredContentInset.top
//                if topDiff < 0 {
//                    topDiff = currentContentInset.top
//                }
//                var bottomDiff = currentContentInset.bottom - requiredContentInset.bottom
//                if bottomDiff < 0 {
//                    bottomDiff = currentContentInset.bottom
//                }
//                requiredContentInset.top += topDiff
//                requiredContentInset.bottom += bottomDiff
 
                requiredContentInset.left = currentContentInset.left
                requiredContentInset.right = currentContentInset.right
                scrollView.contentInset = requiredContentInset
                
                var contentOffset = scrollView.contentOffset
                contentOffset.y = -requiredContentInset.top
                scrollView.contentOffset = contentOffset
            }
        }
    }
}

// MARK: - TabmanBarDataSource, TabmanBarDelegate
extension TabmanViewController: TabmanBarDataSource, TabmanBarDelegate {
    
    public func items(forBar bar: TabmanBar) -> [TabmanBarItem]? {
        if let itemCountLimit = bar.itemCountLimit {
            guard self.bar.items?.count ?? 0 <= itemCountLimit else {
                print("TabmanBar Error:\nItems in bar.items exceed the available count for the current bar style: (\(itemCountLimit)).")
                print("Either reduce the number of items or use a different style. Escaping now.")
                return nil
            }
        }
        
        return self.bar.items
    }
    
    public func bar(_ bar: TabmanBar, didSelectItemAtIndex index: Int) {
        self.scrollToPage(.at(index: index), animated: true)
    }
}

// MARK: - TabmanBarConfigDelegate
extension TabmanViewController: TabmanBarConfigDelegate {
    
    func config(_ config: TabmanBarConfig, didUpdateStyle style: TabmanBar.Style) {
        guard self.attachedTabmanBar == nil else { return }
        
        self.clearUpBar(&self.tabmanBar)
        self.reloadBar(withStyle: style)
        self.updateBar(withLocation: config.location)
    }
    
    func config(_ config: TabmanBarConfig, didUpdateLocation location: TabmanBarConfig.Location) {
        guard self.attachedTabmanBar == nil else { return }

        self.updateBar(withLocation: location)
    }
    
    func config(_ config: TabmanBarConfig, didUpdateAppearance appearance: TabmanBar.Appearance) {
        self.activeTabmanBar?.appearance = appearance
    }
    
    func config(_ config: TabmanBarConfig, didUpdateItems items: [TabmanBarItem]?) {
        self.activeTabmanBar?.reloadData()

        self.view.layoutIfNeeded()
        self.reloadRequiredBarInsets()
    }
}
