//
//  Gradients.swift
//  Pageboy-Example
//
//  Created by Merrick Sapsford on 18/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

class Gradients {
    
    static var all: [Gradient] {
        return [Gradient(top: UIColor(red:0.01, green:0.00, blue:0.18, alpha:1.0), bottom: UIColor(red:0.00, green:0.53, blue:0.80, alpha:1.0)),
                Gradient(top: UIColor(red:0.20, green:0.08, blue:0.00, alpha:1.0), bottom: UIColor(red:0.69, green:0.36, blue:0.00, alpha:1.0)),
                Gradient(top: UIColor(red:0.00, green:0.13, blue:0.05, alpha:1.0), bottom: UIColor(red:0.00, green:0.65, blue:0.33, alpha:1.0)),
                Gradient(top: UIColor(red:0.18, green:0.00, blue:0.20, alpha:1.0), bottom: UIColor(red:0.64, green:0.00, blue:0.66, alpha:1.0)),
                Gradient(top: UIColor(red:0.20, green:0.00, blue:0.00, alpha:1.0), bottom: UIColor(red:0.69, green:0.00, blue:0.00, alpha:1.0))]
    }
}

struct Gradient {
    
    let top: UIColor
    let bottom: UIColor
    
    static var defaultGradient: Gradient {
        return Gradient(top: .black, bottom: .black)
    }
}
