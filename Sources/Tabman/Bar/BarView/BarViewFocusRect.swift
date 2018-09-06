//
//  BarViewFocusRect.swift
//  Tabman
//
//  Created by Merrick Sapsford on 04/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

/// Rect struct similar to CGRect that provides ability to take factors such as capacity and position into account.
internal struct BarViewFocusRect {
    
    // MARK: Properties
    
    private let rect: CGRect
    private let position: CGFloat
    private let capacity: CGFloat
    
    /// Origin of the original rect.
    var origin: CGPoint {
        return rect.origin
    }
    /// Size of the original rect.
    var size: CGSize {
        return rect.size
    }
    
    // MARK: Init
    
    /// Create a FocusRect with an original CGRect at a position.
    ///
    /// - Parameters:
    ///   - rect: The original rect.
    ///   - position: The current page position.
    ///   - capacity: The capacity to use.
    init(rect: CGRect, at position: CGFloat, capacity: Int) {
        self.rect = rect
        self.position = position
        self.capacity = CGFloat(capacity - 1) // Rect capacity is actually zero indexed
    }
    
    /// Get the rect of the FocusRect accounting for additional factors.
    ///
    /// - Parameter isProgressive: Whether the rect should be displayed as progressive (i.e. always increases from initial position)
    /// - Parameter includeOverscroll: Whether to include overscrolling if relevant.
    /// - Returns: Rect with additional factors accounted for.
    func rect(isProgressive: Bool, overscrollBehavior: BarIndicator.OverscrollBehavior) -> CGRect {
        switch isProgressive {
        case true:
            return progressiveRect(with: overscrollBehavior, for: rect)
            
        case false:
            return rect(with: overscrollBehavior, for: rect)
        }
    }
}

private extension BarViewFocusRect {
    
    func rect(with overscrollBehavior: BarIndicator.OverscrollBehavior,
              for rect: CGRect) -> CGRect {
        switch overscrollBehavior {
            
        case .bounce:
            if position < 0.0 {
                return rect.offsetBy(dx: rect.width * position, dy: 0.0)
            } else if position > capacity {
                let delta = position - capacity
                return rect.offsetBy(dx: rect.width * delta, dy: 0.0)
            }
            
        case .compress:
            fatalError()
            
        default:
             break
        }
        return rect
    }
    
    func progressiveRect(with overscrollBehavior: BarIndicator.OverscrollBehavior,
                         for rect: CGRect) -> CGRect {
        var rect = rect
        
        rect.size.width += rect.origin.x
        rect.origin.x = 0.0
        
        switch overscrollBehavior {
        case .bounce:
            if position < 0.0 {
                rect.size.width += rect.width * position
            } else if position > capacity {
                let delta = position - capacity
                rect.size.width += rect.width * delta
            }
            
        case .compress:
            fatalError()
            
        default:
            break
        }
        return rect
    }
}
