//
//  TabmanViewController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Pageboy

open class TabmanViewController: PageboyViewController, PageboyViewControllerDelegate {
    
    // MARK: Properties
    
    /// The Tabman bar.
    fileprivate(set) var tabmanBar: TabmanBar?
    
    /// Configuration for the bar.
    /// Able to set items, appearance, location and style through this object.
    public lazy var bar = TabmanBarConfig()
    
    // MARK: Lifecycle
    
    open override func loadView() {
        super.loadView()
        
        self.delegate = self
        self.bar.delegate = self
        
        // add bar to view
        self.reloadBar(withStyle: self.bar.style)
        self.updateBar(withLocation: self.bar.location)
    }
    
    // MARK: PageboyViewControllerDelegate
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      willScrollToPageAtIndex index: Int,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.tabmanBar?.updatePosition(CGFloat(index), direction: direction)
                self.tabmanBar?.layoutIfNeeded()
            })
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didScrollToPageAtIndex index: Int,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
        self.tabmanBar?.updatePosition(CGFloat(index),
                                    direction: direction)
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didScrollToPosition position: CGPoint,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
        if !animated {
            self.tabmanBar?.updatePosition(pageboyViewController.navigationOrientation == .horizontal ? position.x : position.y,
                                     direction: direction)
        }
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
    func reloadBar(withStyle style: TabmanBarConfig.Style) {
        guard let barType = style.rawType else {
            return
        }
        
        // re create the tab bar with a new style
        let bar = barType.init()
        bar.dataSource = self
        bar.delegate = self
        if let appearance = self.bar.appearance {
            bar.appearance = appearance
        }

        self.tabmanBar = bar
    }
    
    
    /// Update the bar with a new screen location.
    ///
    /// - Parameter location: The new location.
    func updateBar(withLocation location: TabmanBarConfig.Location) {
        guard let bar = self.tabmanBar else {
            return
        }
        
        // use style preferred location if no exact location specified.
        var location = location
        if location == .preferred {
            location = self.bar.style.preferredLocation
        }
        
        bar.removeFromSuperview()
        self.view.addSubview(bar)
        
        // move tab bar to location
        var requiredInsets = UIEdgeInsets.zero
        switch location {
            
        case .top:
            bar.barAutoPinToTop(topLayoutGuide: self.topLayoutGuide)
            requiredInsets.top = bar.intrinsicContentSize.height
        case .bottom:
            bar.barAutoPinToBotton(bottomLayoutGuide: self.bottomLayoutGuide)
            requiredInsets.bottom = bar.intrinsicContentSize.height
            
        default:()
        }
        self.bar.requiredContentInset = requiredInsets
        
        let position = self.navigationOrientation == .horizontal ? self.currentPosition?.x : self.currentPosition?.y
        bar.updatePosition(position ?? 0.0, direction: .neutral)
    }
}

// MARK: - TabmanBarDataSource, TabmanBarDelegate
extension TabmanViewController: TabmanBarDataSource, TabmanBarDelegate {
    
    public func items(forTabBar tabBar: TabmanBar) -> [TabmanBarItem]? {
        return self.bar.items
    }
    
    public func tabBar(_ tabBar: TabmanBar, didSelectTabAtIndex index: Int) {
        self.scrollToPage(.atIndex(index: index), animated: true)
    }
}

// MARK: - TabmanBarConfigDelegate
extension TabmanViewController: TabmanBarConfigDelegate {
    
    func config(_ config: TabmanBarConfig, didUpdateStyle style: TabmanBarConfig.Style) {
        self.clearUpBar(&self.tabmanBar)
        self.reloadBar(withStyle: style)
        self.updateBar(withLocation: config.location)
    }
    
    func config(_ config: TabmanBarConfig, didUpdateLocation location: TabmanBarConfig.Location) {
        self.updateBar(withLocation: location)
    }
    
    func config(_ config: TabmanBarConfig, didUpdateAppearance appearance: TabmanBar.AppearanceConfig) {
        self.tabmanBar?.appearance = appearance
    }
    
    func config(_ config: TabmanBarConfig, didUpdateItems items: [TabmanBarItem]?) {
        self.tabmanBar?.reloadData()
    }
}
