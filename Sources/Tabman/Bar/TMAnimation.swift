//
//  TMAnimation.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

/// Style of animation to use.
///
/// - progressive: <#progressive description#>
/// - snap: <#snap description#>
/// - none: <#none description#>
public enum TMAnimationStyle {
    case progressive
    case snap
    case none
}

/// Configuration for an animation.
public struct TMAnimation {
    /// Whether the animation is enabled.
    public let isEnabled: Bool
    /// Duration of the animation in seconds.
    public let duration: TimeInterval
}

/// Object that can provide an animation style.
internal protocol TMAnimationStyleable: class {
    
    var animationStyle: TMAnimationStyle { get }
}
