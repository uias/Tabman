//
//  UIView+DefaultTintColor.swift
//  Tabman
//
//  Created by Merrick Sapsford on 05/12/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import UIKit

internal extension UIView {
    
    /// The default tintColor of UIView
    class var defaultTintColor: UIColor {
        let view = UIView()
        return view.tintColor
    }
}
