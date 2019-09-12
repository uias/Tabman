//
//  UIView+LayoutGuide.swift
//  Tabman
//
//  Created by Nghia Nguyen on 6/17/19.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

extension UIView {
    @available(iOS 11.0, *)
    private var internalSafeAreaLayoutGuide: UILayoutGuide? {
        if self.responds(to: #selector(getter: UIView.safeAreaLayoutGuide)) == .some(true) {
            return self.safeAreaLayoutGuide
        } else {
            return nil
        }
    }
    
    @available(iOS 11.0, *)
    var safeAreaTopAnchor: NSLayoutYAxisAnchor {
        return internalSafeAreaLayoutGuide?.topAnchor ?? topAnchor
    }
    
    @available(iOS 11.0, *)
    var safeAreaBottomAnchor: NSLayoutYAxisAnchor {
        return internalSafeAreaLayoutGuide?.bottomAnchor ?? bottomAnchor
    }
    
    @available(iOS 11.0, *)
    var safeAreaTrailingAnchor: NSLayoutXAxisAnchor {
        return internalSafeAreaLayoutGuide?.trailingAnchor ?? trailingAnchor
    }
    
    @available(iOS 11.0, *)
    var safeAreaLeadingAnchor: NSLayoutXAxisAnchor {
        return internalSafeAreaLayoutGuide?.leadingAnchor ?? leadingAnchor
    }
}
