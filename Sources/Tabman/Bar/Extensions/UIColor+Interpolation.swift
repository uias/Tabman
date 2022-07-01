//
//  ColorUtils.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/02/2017.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

internal extension UIColor {
    
    func interpolate(with other: UIColor, percent: CGFloat) -> UIColor? {
        return UIColor.interpolate(betweenColor: self, and: other, percent: percent)
    }
    
    static func interpolate(betweenColor colorA: UIColor,
                            and colorB: UIColor,
                            percent: CGFloat) -> UIColor? {
        var redA: CGFloat = 0.0
        var greenA: CGFloat = 0.0
        var blueA: CGFloat = 0.0
        var alphaA: CGFloat = 0.0
        
        var redB: CGFloat = 0.0
        var greenB: CGFloat = 0.0
        var blueB: CGFloat = 0.0
        var alphaB: CGFloat = 0.0
        
        var iRed: CGFloat { CGFloat(redA + percent * (redB - redA)) }
        var iBlue: CGFloat { CGFloat(blueA + percent * (blueB - blueA)) }
        var iGreen: CGFloat { CGFloat(greenA + percent * (greenB - greenA)) }
        var iAlpha: CGFloat { CGFloat(alphaA + percent * (alphaB - alphaA)) }
        var interpolatedColor: UIColor { UIColor(red: iRed, green: iGreen, blue: iBlue, alpha: iAlpha) }
        
        if #available(iOS 13, *) {
            return UIColor(dynamicProvider: { traitCollection in
                traitCollection.performAsCurrent {
                    guard colorA.getRed(&redA, green: &greenA, blue: &blueA, alpha: &alphaA) else {
                        return
                    }
                    
                    guard colorB.getRed(&redB, green: &greenB, blue: &blueB, alpha: &alphaB) else {
                        return
                    }
                }
                
                return interpolatedColor
            })
        } else {
            guard colorA.getRed(&redA, green: &greenA, blue: &blueA, alpha: &alphaA) else {
                return nil
            }
            
            guard colorB.getRed(&redB, green: &greenB, blue: &blueB, alpha: &alphaB) else {
                return nil
            }
            
            return interpolatedColor
        }
    }
}
