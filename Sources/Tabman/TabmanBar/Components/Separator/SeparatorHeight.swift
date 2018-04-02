//
//  SeparatorHeight.swift
//  Tabman
//
//  Created by Merrick Sapsford on 02/04/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// Height for separator view.
///
/// - thin: 0.5 pt
/// - medium: 1.5 pt
/// - thick: 3.0 pt
/// - custom: Custom specified height.
public enum SeparatorHeight {
    
    case thin
    case medium
    case thick
    case custom(height: CGFloat)
    
    /// Default height to use.
    static var `default`: SeparatorHeight = .thin
    
    /// Actual raw height value.
    var rawValue: CGFloat {
        switch self {
        case .thin:
            return 0.5
        case .medium:
            return 1.5
        case .thick:
            return 3.0
        case .custom(let height):
            return height
        }
    }
}
