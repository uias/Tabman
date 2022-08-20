//
//  CGRect+Interpolation.swift
//  Tabman
//
//  Created by Merrick Sapsford on 07/06/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

extension CGRect {
    
    func interpolate(with other: CGRect, progress: CGFloat) -> CGRect {
        return CGRect(x: (other.origin.x - origin.x) * progress,
                      y: (other.origin.y - origin.y) * progress,
                      width: (other.size.width - size.width) * progress,
                      height: (other.size.height - size.height) * progress)
    }
}
