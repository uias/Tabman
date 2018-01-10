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
            Gradient(topColorHex: "#004C9E", bottomColorHex: "#ECF5FF"),
            Gradient(topColorHex: "#760094", bottomColorHex: "#FAE7FF"),
            Gradient(topColorHex: "#950000", bottomColorHex: "#FFCFCF"),
            Gradient(topColorHex: "#A69900", bottomColorHex: "#FFFCD8"),
            Gradient(topColorHex: "#239300", bottomColorHex: "#EAFFE3")
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
