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
            self.reloadTabBar(withStyle: tabBarStyle)
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
                                      direction: PageboyViewController.NavigationDirection) {
        
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didScrollToPageWithIndex index: Int,
                                      direction: PageboyViewController.NavigationDirection) {
        
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didScrollToPosition position: CGPoint,
                                      direction: PageboyViewController.NavigationDirection) {
        
    }
    
}

internal extension TabmanViewController {
    
    func reloadTabBar(withStyle style: TabmanBar.Style) {
        guard let barType = style.rawType else {
            return
        }
        
        // re create the tab bar with a new style
        let bar = barType.init()
        bar.dataSource = self
        bar.backgroundColor = .red
        
        self.tabBar = bar
    }
    
    func updateTabBar(withLocation location: TabmanBar.Location) {
        guard let tabBar = self.tabBar else {
            return
        }
        
        if tabBar.superview == nil {
            self.view.addSubview(tabBar)
        }
        
        // move tab bar to location
        switch location {
            
        case .top:
            tabBar.tabBarAutoPinToTop(topLayoutGuide: self.topLayoutGuide)
        case .bottom:
            tabBar.tabBarAutoPinToBotton(bottomLayoutGuide: self.bottomLayoutGuide)
            
        }
    }
}

extension TabmanViewController: TabmanBarDataSource {
    
    public func items(forTabBar tabBar: TabmanBar) -> [TabmanBarItem]? {
        return nil
    }
}
