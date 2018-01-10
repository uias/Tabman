//
//  UIView+Localization.swift
//  Tabman
//
//  Created by Merrick Sapsford on 05/12/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import UIKit

internal extension UIView {
    
    /// Whether the layout direction of the view is right to left.
    var layoutIsRightToLeft: Bool {
        if #available(iOS 9.0, *) {
            return UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft
        } else {
            return UIApplication.safeShared?.userInterfaceLayoutDirection == .rightToLeft
        }
    }
}
