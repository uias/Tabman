//
//  BarIndicatorStyle.swift
//  Tabman
//
//  Created by Merrick Sapsford on 07/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

public enum BarIndicatorStyle {
    case line
}

internal extension BarIndicatorStyle {
    
    static var `default`: BarIndicatorStyle {
        return .line
    }
}
