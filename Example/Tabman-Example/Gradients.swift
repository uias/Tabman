//
//  Gradients.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 15/09/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import UIKit

class Gradient {
    var colors: [UIColor]
    
    static var defaultGradient: Gradient {
        return Gradient(colors: .black, .black)
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
            Gradient(colorHexs: "#833AB4", "#FD1D1D", "#FCB045"),
            Gradient(colorHexs: "#D32750", "#FA5B30", "#FCB045"),
            Gradient(colorHexs: "#FCB045", "#FC7635", "#FCB045"),
            Gradient(colorHexs: "#FCB045", "#FA5B30", "#D32750"),
            Gradient(colorHexs: "#FCB045", "#FD1D1D", "#833AB4")
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
