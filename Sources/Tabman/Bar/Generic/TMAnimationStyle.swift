//
//  TMAnimationStyle.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

public enum TMAnimationStyle {
    case progressive
    case snap
    case none
}

internal protocol TMAnimatable {
    
    var animationStyle: TMAnimationStyle { get }
}
