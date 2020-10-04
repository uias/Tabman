//
//  TMHorizontalInsets.swift
//  Tabman
//
//  Created by Merrick Sapsford on 04/05/2020.
//  Copyright © 2020 UI At Six. All rights reserved.
//

import UIKit

/// Horizontal insets that can be applied to bars.
public struct TMHorizontalInsets {
    
    /// Left inset.
    public let left: CGFloat
    /// Right inset.
    public let right: CGFloat
    
    /// Create new horizontal insets.
    /// - Parameters:
    ///   - left: Left.
    ///   - right: Right.
    public init(left: CGFloat, right: CGFloat) {
        self.left = left
        self.right = right
    }
    
    /// Zero insets.
    public static var zero = TMHorizontalInsets(left: 0.0, right: 0.0)
}
