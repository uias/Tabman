//
//  UIView+Subviews.swift
//  Tabman
//
//  Created by Merrick Sapsford on 31/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

extension UIView {
    
    func removeAllSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
}
