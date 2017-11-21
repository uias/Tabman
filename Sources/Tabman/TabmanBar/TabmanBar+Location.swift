//
//  TabmanBar+Location.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import Foundation

public extension TabmanBar {
    
    /// The location of the bar on screen.
    ///
    /// - perferred: Use the preferred location for the current style.
    /// - top: At the top. (Note: this will take account of UINavigationBar etc.)
    /// - bottom: At the bottom. (Note: this will take account of UITabBar etc.)
    public enum Location {
        case preferred
        case top
        case bottom
    }
}

// MARK: - Additional Style properties for internal use
internal extension TabmanBar.Style {
    
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
