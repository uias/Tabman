//
//  BarMath.swift
//  Tabman
//
//  Created by Merrick Sapsford on 07/06/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

class BarMath {
    
    static func localIndexRange(for position: CGFloat, minimum: Int, maximum: Int) -> Range<Int> {
        guard maximum > minimum else {
            return 0 ..< 0
        }
        let lower = floor(position)
        let upper = ceil(position)
        let minimum = CGFloat(minimum)
        let maximum = CGFloat(maximum)
        
        return Int(max(minimum, min(maximum, lower))) ..< Int(min(maximum, max(minimum, upper)))
    }
    
    static func localProgress(for position: CGFloat) -> CGFloat {
        var integral: Float = 0.0
        return CGFloat(modff(Float(position), &integral))
    }
}
