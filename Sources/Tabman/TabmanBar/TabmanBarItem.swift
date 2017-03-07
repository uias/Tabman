//
//  TabmanBarItem.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

/// An item to display in a TabmanBar.
public struct TabmanBarItem: Any {
    
    // MARK: Properties
    
    /// The title to display in the item.
    public var displayTitle: String?
    
    // MARK: Init
    
    /// Create an item.
    init() {
        
    }
    
    /// Create an item with a title.
    ///
    /// - Parameter title: The title to display.
    public init(title: String) {
        self.displayTitle = title
    }
}
