//
//  TabmanColorUtils.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

internal extension UIColor {
    
    static func interpolate(betweenColor colorA: UIColor,
                     and colorB: UIColor,
                     percent: CGFloat) -> UIColor? {
        var redA: CGFloat = 0.0
        var greenA: CGFloat = 0.0
        var blueA: CGFloat = 0.0
        var alphaA: CGFloat = 0.0
        guard colorA.getRed(&redA, green: &greenA, blue: &blueA, alpha: &alphaA) else {
            return nil
        }
        
        var redB: CGFloat = 0.0
        var greenB: CGFloat = 0.0
        var blueB: CGFloat = 0.0
        var alphaB: CGFloat = 0.0
        guard colorB.getRed(&redB, green: &greenB, blue: &blueB, alpha: &alphaB) else {
            return nil
        }
        
        let iRed = Float(redA + percent * (redB - redA))
        let iBlue = Float(blueA + percent * (blueB - blueA))
        let iGreen = Float(greenA + percent * (greenB - greenA))
        let iAlpha = Float(alphaA + percent * (alphaB - alphaA))
        
        return UIColor(colorLiteralRed: iRed, green: iGreen, blue: iBlue, alpha: iAlpha)
    }
}
