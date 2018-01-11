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
            Gradient(colorHexs: "#833AB4", "#FD1D54", "#FC8D45"),
            Gradient(colorHexs: "#AF2F91", "#DF246B", "#FC604B"),
            Gradient(colorHexs: "#833AB4", "#FD1D54", "#FC8D45"),
            Gradient(colorHexs: "#833AB4", "#FD1D1D", "#FCB045")
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
