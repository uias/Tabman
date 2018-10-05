//
//  UIGradient+Metadata.swift
//  Randient
//
//  Created by Merrick Sapsford on 18/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public extension UIGradient {
    
    /// Gradient Metadata
    public struct Metadata {
        
        /// Whether the gradients color space is primarily 'light' colors.
        public let isPredominantlyLight: Bool
    }
    
    /// Metadata about the gradient.
    var metadata: Metadata {
        return Metadata(isPredominantlyLight: self.isLight)
    }
}

private extension UIGradient {
    
    var isLight: Bool {
        let lightColors = data.colors.filter({ $0.isLight })
        let darkColors = data.colors.filter({ !lightColors.contains($0) })
        return lightColors.count > darkColors.count
    }
}
