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
    
    internal(set) var bar: TabmanBar?
    
    public var barStyle: TabmanBar.Style = .buttonBar {
        didSet {
            guard barStyle != oldValue else {
                return
            }
            self.clearUpBar(&self.bar)
            self.reloadBar(withStyle: self.barStyle)
            self.updateBar(withLocation: self.barLocation)
        }
    }
    public var barLocation: TabmanBar.Location = .top {
        didSet {
            guard barLocation != oldValue else {
                return
            }
            self.updateBar(withLocation: barLocation)
        }
    }
    
    public var barItems: [TabmanBarItem]? {
        didSet {
            self.bar?.reloadData()
        }
    }
    
    public var barAppearance: TabmanBar.AppearanceConfig? {
        set {
            guard let newValue = newValue else {
                return
            }
            self.bar?.appearance = newValue
        }
        get {
            return self.bar?.appearance
        }
    }
    
    // MARK: Lifecycle
    
    open override func loadView() {
        super.loadView()
        
        self.delegate = self
        
        // add bar to view
        self.reloadBar(withStyle: self.barStyle)
        self.updateBar(withLocation: self.barLocation)
    }
    
    // MARK: PageboyViewControllerDelegate
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      willScrollToPageAtIndex index: Int,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.bar?.updatePosition(CGFloat(index), direction: direction)
                self.bar?.layoutIfNeeded()
            })
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didScrollToPageAtIndex index: Int,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
        self.bar?.updatePosition(CGFloat(index),
                                    direction: direction)
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                      didScrollToPosition position: CGPoint,
                                      direction: PageboyViewController.NavigationDirection,
                                      animated: Bool) {
        if !animated {
            self.bar?.updatePosition(pageboyViewController.navigationOrientation == .horizontal ? position.x : position.y,
                                     direction: direction)
        }
    }
}

internal extension TabmanViewController {
    
    func clearUpBar(_ bar: inout TabmanBar?) {
        bar?.removeFromSuperview()
        bar = nil
    }
    
    func reloadBar(withStyle style: TabmanBar.Style) {
        guard let barType = style.rawType else {
            return
        }
        
        // re create the tab bar with a new style
        let bar = barType.init()
        bar.dataSource = self
        bar.delegate = self
        
        self.bar = bar
    }
    
    func updateBar(withLocation location: TabmanBar.Location) {
        guard let bar = self.bar else {
            return
        }
        
        bar.removeFromSuperview()
        self.view.addSubview(bar)

        // move tab bar to location
        switch location {
            
        case .top:
            bar.barAutoPinToTop(topLayoutGuide: self.topLayoutGuide)
        case .bottom:
            bar.barAutoPinToBotton(bottomLayoutGuide: self.bottomLayoutGuide)
        }
        
        let position = self.navigationOrientation == .horizontal ? self.currentPosition?.x : self.currentPosition?.y
        bar.updatePosition(position ?? 0.0, direction: .neutral)
    }
}

extension TabmanViewController: TabmanBarDataSource, TabmanBarDelegate {
    
    public func items(forTabBar tabBar: TabmanBar) -> [TabmanBarItem]? {
        return self.barItems
    }
    
    public func tabBar(_ tabBar: TabmanBar, didSelectTabAtIndex index: Int) {
        self.scrollToPage(.atIndex(index: index), animated: true)
    }
}
