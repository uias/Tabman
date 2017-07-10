//
//  UIView+Utils.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

internal extension UIView {
    
    internal func removeAllSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
}

internal extension UIView {
    
    /// Whether the layout direction of the view is right to left.
    var layoutIsRightToLeft: Bool {
        if #available(iOS 9.0, *) {
            return UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft
        } else {
            return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
        }
    }
}
