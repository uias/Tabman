//
//  BarViewFocusRect.swift
//  Tabman
//
//  Created by Merrick Sapsford on 04/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

internal struct BarViewFocusRect {
    
    // MARK: Properties
    
    private let rect: CGRect
    private let position: CGFloat
    private let capacity: CGFloat
    
    var origin: CGPoint {
        return rect.origin
    }
    var size: CGSize {
        return rect.size
    }
    
    // MARK: Init
    
    init(rect: CGRect, at position: CGFloat, capacity: Int) {
        self.rect = rect
        self.position = position
        self.capacity = CGFloat(capacity - 1)
    }
    
    func rect(includeOverscroll: Bool) -> CGRect {
        switch includeOverscroll {
            
        case true:
            if position < 0.0 {
                return rect.offsetBy(dx: rect.width * position, dy: 0.0)
            } else if position > capacity {
                let delta = position - capacity
                return rect.offsetBy(dx: rect.width * delta, dy: 0.0)
            }
            return rect
            
        default:
            return rect
        }
    }
}
