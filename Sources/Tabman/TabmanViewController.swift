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
    
    internal(set) public var tabBar: TabmanBar?
    
    public var tabBarStyle: TabmanBar.Style = .buttonBar {
        didSet {
            guard tabBarStyle != oldValue else {
                return
            }
            self.clearUpTabBar(tabBar: &self.tabBar)
            self.reloadTabBar(withStyle: tabBarStyle)
            self.updateTabBar(withLocation: self.tabBarLocation)
        }
    }
    public var tabBarLocation: TabmanBar.Location = .top {
        didSet {
            guard tabBarLocation != oldValue else {
                return
            }
            self.updateTabBar(withLocation: tabBarLocation)
        }
    }
    
    public var tabBarItems: [TabmanBarItem]? {
        didSet {
            self.tabBar?.reloadData()
        }
    }
    
    // MARK: Lifecycle
    
    open override func loadView() {
        super.loadView()
        
        self.delegate = self
        
        // add tab bar to view
        self.reloadTabBar(withStyle: self.tabBarStyle)
        self.updateTabBar(withLocation: self.tabBarLocation)
    }
    
    // MARK: PageboyViewControllerDelegate
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      willScrollToPageAtIndex index: Int,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.tabBar?.updatePosition(CGFloat(index), direction: direction)
                self.tabBar?.layoutIfNeeded()
            })
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didScrollToPageAtIndex index: Int,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
        self.tabBar?.updatePosition(CGFloat(index),
                                    direction: direction)
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didScrollToPosition position: CGPoint,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
        if !animated {
            self.tabBar?.updatePosition(pageboyViewController.navigationOrientation == .horizontal ? position.x : position.y,
                                        direction: direction)
        }
    }
}

internal extension TabmanViewController {
    
    func clearUpTabBar(tabBar: inout TabmanBar?) {
        tabBar?.removeFromSuperview()
        tabBar = nil
    }
    
    func reloadTabBar(withStyle style: TabmanBar.Style) {
        guard let barType = style.rawType else {
            return
        }
        
        // re create the tab bar with a new style
        let bar = barType.init()
        bar.dataSource = self
        bar.delegate = self
        
        self.tabBar = bar
    }
    
    func updateTabBar(withLocation location: TabmanBar.Location) {
        guard let tabBar = self.tabBar else {
            return
        }
        
        tabBar.removeFromSuperview()
        self.view.addSubview(tabBar)

        // move tab bar to location
        switch location {
            
        case .top:
            tabBar.tabBarAutoPinToTop(topLayoutGuide: self.topLayoutGuide)
        case .bottom:
            tabBar.tabBarAutoPinToBotton(bottomLayoutGuide: self.bottomLayoutGuide)
        }
        
        let position = self.navigationOrientation == .horizontal ? self.currentPosition?.x : self.currentPosition?.y
        tabBar.updatePosition(position ?? 0.0, direction: .neutral)
    }
}

extension TabmanViewController: TabmanBarDataSource, TabmanBarDelegate {
    
    public func items(forTabBar tabBar: TabmanBar) -> [TabmanBarItem]? {
        return self.tabBarItems
    }
    
    public func tabBar(_ tabBar: TabmanBar, didSelectTabAtIndex index: Int) {
        self.scrollToPage(.atIndex(index: index), animated: true)
    }
}
