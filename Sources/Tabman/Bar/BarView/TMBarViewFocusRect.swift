//
//  TMBarViewFocusRect.swift
//  Tabman
//
//  Created by Merrick Sapsford on 04/09/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

/// Rect struct similar to CGRect that provides ability to take factors such as capacity and position into account.
internal struct TMBarViewFocusRect {
    
    // MARK: Properties
    
    private let rect: CGRect
    private let maxRect: CGRect
    private let position: CGFloat
    private let capacity: CGFloat
    private let layoutDirection: UIUserInterfaceLayoutDirection
    
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
    ///   - layoutDirection: Layout direction of the user interface.
    init(rect: CGRect, maxRect: CGRect, at position: CGFloat, capacity: Int, layoutDirection: UIUserInterfaceLayoutDirection) {
        self.rect = rect
        self.maxRect = maxRect
        self.position = position
        self.capacity = CGFloat(capacity - 1) // Rect capacity is actually zero indexed
        self.layoutDirection = layoutDirection
    }
    
    /// Get the rect of the FocusRect accounting for additional factors.
    ///
    /// - Parameter isProgressive: Whether the rect should be displayed as progressive (i.e. always increases from initial position)
    /// - Parameter includeOverscroll: Whether to include overscrolling if relevant.
    /// - Returns: Rect with additional factors accounted for.
    func rect(isProgressive: Bool, overscrollBehavior: TMBarIndicator.OverscrollBehavior) -> CGRect {
        switch isProgressive {
        case true:
            return progressiveRect(with: overscrollBehavior, for: rect)
            
        case false:
            return rect(with: overscrollBehavior, for: rect)
        }
    }
}

private extension TMBarViewFocusRect {
    
    func rect(with overscrollBehavior: TMBarIndicator.OverscrollBehavior,
              for rect: CGRect) -> CGRect {
        var rect = rect
        let isLeftToRight = layoutDirection == .leftToRight
        
        switch overscrollBehavior {
            
        case .bounce:
            if position < 0.0 {
                let xOffset = rect.width * position
                rect = rect.offsetBy(dx: isLeftToRight ? xOffset : -xOffset, dy: 0.0)
            } else if position > capacity {
                let delta = position - capacity
                let xOffset = rect.width * delta
                rect = rect.offsetBy(dx: isLeftToRight ? xOffset : -xOffset, dy: 0.0)
            }
            
        case .compress:
            if position < 0.0 {
                let delta = rect.width * position
                if !isLeftToRight {
                    rect.origin.x -= delta
                }
                rect.size.width += delta
            } else if position > capacity {
                let delta = rect.width * (position - capacity)
                rect.size.width -= delta
                if isLeftToRight {
                    rect.origin.x += delta
                }
            }
            
        default:
             break
        }
        return rect
    }
    
    func progressiveRect(with overscrollBehavior: TMBarIndicator.OverscrollBehavior,
                         for rect: CGRect) -> CGRect {
        var rect = rect
        let isLeftToRight = layoutDirection == .leftToRight
        
        if isLeftToRight {
            rect.size.width += rect.origin.x
            rect.origin.x = 0.0
        } else {
            rect.size.width = maxRect.size.width - rect.origin.x
        }
        
        switch overscrollBehavior {
        case .bounce, .compress:
            if position < 0.0 {
                let delta = rect.width * position
                if !isLeftToRight {
                    rect.origin.x -= delta
                }
                rect.size.width +=  delta
            } else if position > capacity && overscrollBehavior != .compress {
                let delta = position - capacity
                let xOffset = (maxRect.size.width - rect.width) * delta
                rect = rect.offsetBy(dx: isLeftToRight ? xOffset : -xOffset, dy: 0.0)
            }
            
        default:
            break
        }
        return rect
    }
}
