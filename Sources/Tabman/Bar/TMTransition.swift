//
//  TMTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/10/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import Foundation

/// Style of transition to use for updates.
///
/// - progressive: Progress will transition smoothly, and interpolate between values.
/// - snap: Progress will transition between ranges when the mid-threshold is reached using animation.
/// - none: Progress will transition between ranges when the mid-threshold is reached without any animation.
public enum TMTransitionStyle {
    case progressive
    case snap
    case none
}

/// Object that can provide an animation style.
internal protocol TMTransitionStyleable: class {
    
    var transitionStyle: TMTransitionStyle { get set }
}
