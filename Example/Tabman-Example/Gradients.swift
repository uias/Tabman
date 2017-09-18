//
//  Gradients.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 15/09/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import UIKit

struct Gradient {
    let topColor: UIColor
    let bottomColor: UIColor
    
    static var defaultGradient: Gradient {
        return Gradient(topColor: .black, bottomColor: .black)
    }
    
    // MARK: Init
    
    init(topColor: UIColor, bottomColor: UIColor) {
        self.topColor = topColor
        self.bottomColor = bottomColor
    }
    
    init(topColorHex: String, bottomColorHex: String) {
        self.topColor = UIColor.fromHex(string: topColorHex)
        self.bottomColor = UIColor.fromHex(string: bottomColorHex)
    }
}

extension TabViewController {
    
    var gradients: [Gradient] {
        return [
            Gradient(topColorHex: "#ff0084", bottomColorHex: "#640736"),
            Gradient(topColorHex: "#f09819", bottomColorHex: "#704d0e"),
            Gradient(topColorHex: "#3498db", bottomColorHex: "#2c3e50"),
            Gradient(topColor: UIColor(red:1.00, green:0.00, blue:0.80, alpha:1.0), bottomColor: UIColor(red:0.20, green:0.20, blue:0.60, alpha:1.0)),
            Gradient(topColor: UIColor(red:0.20, green:0.91, blue:0.62, alpha:1.0), bottomColor: UIColor(red:0.06, green:0.20, blue:0.26, alpha:1.0))
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
