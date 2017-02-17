//
//  TabmanBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

public protocol TabmanBarDataSource {
    
    func items(forTabBar tabBar: TabmanBar) -> [TabmanBarItem]?
}

public class TabmanBar: UIView {
    
    //
    // MARK: Types
    //
    
    public enum Style {
        case buttonBar
        case progressiveBar
        case segmented
    }
    
    public enum Location {
        case top
        case bottom
    }
    
    //
    // MARK: Properties
    //
    
    public var dataSource: TabmanBarDataSource?
    
}

internal extension TabmanBar.Style {
    
    var rawType: TabmanBar.Type? {
        switch self {
            
        case .buttonBar:
            return TabmanButtonBar.self
            
        default:()
        }
        return nil
    }
    
}
