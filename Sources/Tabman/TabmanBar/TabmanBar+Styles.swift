//
//  TabmanBar+Styles.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import Foundation

public extension TabmanBar {
    
    /// The style of the bar.
    ///
    /// - bar: A simple horizontal bar only.
    /// - buttonBar: A horizontal bar with evenly distributed buttons for each page index.
    /// - scrollingButtonBar: A scrolling horizontal bar with buttons for each page index.
    /// - blockTabBar: A tab bar with sliding block style indicator behind tabs.
    /// - custom: A custom defined TabmanBar type.
    public enum Style {
        case bar
        case buttonBar
        case scrollingButtonBar
        case blockTabBar
        case custom(type: TabmanBar.Type)
    }
}

// MARK: - TabmanBarConfig.Style Typing
internal extension TabmanBar.Style {
    
    var rawType: TabmanBar.Type? {
        switch self {
            
        case .bar:
            return TabmanLineBar.self
            
        case .buttonBar:
            return TabmanFixedButtonBar.self
            
        case .scrollingButtonBar:
            return TabmanScrollingButtonBar.self
            
        case .blockTabBar:
            return TabmanBlockTabBar.self
            
        case .custom(let type):
            return type
        }
    }
    
    /// Where the bar is preferred to be displayed for the style.
    var preferredLocation: TabmanBar.Location {
        switch self {
            
        case .bar:
            return .bottom
            
        default:
            return .top
        }
    }
}
