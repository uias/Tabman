//
//  TMAnimation.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/10/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import Foundation

/// Configuration for an animation.
public struct TMAnimation {
    /// Whether the animation is enabled.
    public let isEnabled: Bool
    /// Duration of the animation in seconds.
    public let duration: TimeInterval

    /// Create an animation configuration.
    ///
    /// - Parameters:
    ///   - isEnabled: Whether the animation is enabled.
    ///   - duration: Duration of the animation in seconds.
    public init(isEnabled: Bool, duration: TimeInterval) {
        self.isEnabled = isEnabled
        self.duration = duration
    }
}
