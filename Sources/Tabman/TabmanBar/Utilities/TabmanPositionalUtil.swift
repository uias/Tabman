//
//  PositionalUtils.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation
import Pageboy

internal class TabmanPositionalUtil {
    
    /// Get the lower & upper tab indexes for a current relative position.
    ///
    /// - Parameters:
    ///   - position: The current position.
    ///   - minimum: The minimum possible index.
    ///   - maximum: The maximum possible index.
    /// - Returns: The lower and upper indexes for the position.
    static func lowerAndUpperIndex(forPosition position: CGFloat, minimum: Int, maximum: Int) -> (Int, Int) {
        let lowerIndex = floor(position)
        let upperIndex = ceil(position)
        let minimum = CGFloat(minimum)
        let maximum = CGFloat(maximum)
        
        return (Int(max(minimum, min(maximum, lowerIndex))),
                Int(min(maximum, max(minimum, upperIndex))))
    }
    
    /// Get the target index that a transition is travelling toward.
    ///
    /// - Parameters:
    ///   - position: The current position.
    ///   - direction: The current travel direction.
    ///   - range: The valid range of indexes.
    /// - Returns: The target index.
    static func targetIndex(forPosition position: CGFloat,
                            direction: PageboyViewController.NavigationDirection,
                            range: Range<Int>) -> Int {
        var index: Int!
        switch direction {
        case .reverse:
            index = Int(floor(position))
        default:
            index = Int(ceil(position))
        }
        return max(range.lowerBound, min(range.upperBound - 1, index))
    }
}
