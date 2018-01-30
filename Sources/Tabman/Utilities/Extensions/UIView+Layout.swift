//
//  UIView+Utils.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal extension UIView {
    
    internal func removeAllSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
}
