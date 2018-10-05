//
//  UIColor+Analysis.swift
//  Randient
//
//  Created by Merrick Sapsford on 18/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal extension UIColor {
    
    var isLight: Bool {
        guard let components = cgColor.components else {
            return false
        }
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        return brightness >= 0.5
    }
}

