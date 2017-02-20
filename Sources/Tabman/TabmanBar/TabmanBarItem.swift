//
//  TabmanBarItem.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public struct TabmanBarItem: Any {
    
    public var displayTitle: String?
    
    public init(title: String) {
        self.displayTitle = title
    }
}
