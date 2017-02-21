//
//  TabmanBarCalculations.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

internal extension TabmanBar {
    
    /// Get the lower & upper tab indexes for a current relative position.
    ///
    /// - Parameters:
    ///   - position: The current position.
    ///   - minimum: The minimum possible index.
    ///   - maximum: The maximum possible index.
    /// - Returns: The lower and upper indexes for the position.
    func lowerAndUpperIndex(forPosition position: CGFloat, minimum: Int, maximum: Int) -> (Int, Int) {
        let lowerIndex = floor(position)
        let upperIndex = ceil(position)
        
        return (Int(max(CGFloat(minimum), lowerIndex)),
                Int(min(CGFloat(maximum), upperIndex)))
    }
    
}
