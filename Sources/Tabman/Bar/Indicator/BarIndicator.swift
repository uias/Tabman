//
//  BarIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 07/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

open class BarIndicator: UIView {
    
}

internal extension BarIndicator {
    
    static func `for`(style: BarIndicatorStyle) -> BarIndicator {
        switch style {
        case .line:
            return BarIndicator()
        }
    }
}
