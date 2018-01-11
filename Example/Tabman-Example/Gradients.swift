//
//  Gradients.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 15/09/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import UIKit

struct Gradient {
    let colors: [UIColor]
    
    static var defaultGradient: Gradient {
        return Gradient(colors: .black)
    }
    
    var firstColor: UIColor? {
        return colors.first
    }
    var midColor: UIColor? {
        let midIndex = colors.count / 2
        guard colors.count > midIndex else {
            return nil
        }
        return colors[midIndex]
    }
    
    var lastColor: UIColor? {
        return colors.last
    }
    
    // MARK: Init
    
    init(colors: UIColor...) {
        self.colors = colors
    }
    
    init(colorHexs: String...) {
        var colors = [UIColor]()
        colorHexs.forEach { (hex) in
            colors.append(UIColor.fromHex(string: hex))
        }
        self.colors = colors
    }
}

extension TabViewController {
    
    var gradients: [Gradient] {
        return [
            Gradient(colorHexs: "#ECF5FF", "#004C9E"),
            Gradient(colorHexs: "#FAE7FF", "#760094"),
            Gradient(colorHexs: "#FFCFCF", "#950000"),
            Gradient(colorHexs: "#FFFCD8", "#A69900"),
            Gradient(colorHexs: "#EAFFE3", "#239300")
        ]
    }
    
}

fileprivate extension UIColor {
    
    class func fromHex(string: String) -> UIColor {
        var hex = string
        if hex.hasPrefix("#") {
            hex = String(hex.dropFirst())
        }
        
        let hexVal = Int(hex, radix: 16)!
        return UIColor(red:   CGFloat( (hexVal & 0xFF0000) >> 16 ) / 255.0,
                       green: CGFloat( (hexVal & 0x00FF00) >> 8 ) / 255.0,
                       blue:  CGFloat( (hexVal & 0x0000FF) >> 0 ) / 255.0,
                       alpha: 1.0)
    }
}
