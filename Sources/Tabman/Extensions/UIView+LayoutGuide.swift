//
//  UIView+LayoutGuide.swift
//  Tabman
//
//  Created by Nghia Nguyen on 6/17/19.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import Foundation

extension UIView {
    @available(iOS 11.0, *)
    private var crs_safeAreaLayoutGuide: UILayoutGuide? {
        if self.responds(to: #selector(getter: UIView.safeAreaLayoutGuide)) == .some(true) {
            return self.safeAreaLayoutGuide
        } else {
            return nil
        }
    }
    
    @available(iOS 11.0, *)
    var crs_safeAreaTopAnchor: NSLayoutYAxisAnchor {
        return crs_safeAreaLayoutGuide?.topAnchor ?? topAnchor
    }
    
    @available(iOS 11.0, *)
    var crs_safeAreaBottomAnchor: NSLayoutYAxisAnchor {
        return crs_safeAreaLayoutGuide?.bottomAnchor ?? bottomAnchor
    }
    
    @available(iOS 11.0, *)
    var crs_safeAreaTrailingAnchor: NSLayoutXAxisAnchor {
        return crs_safeAreaLayoutGuide?.trailingAnchor ?? trailingAnchor
    }
    
    @available(iOS 11.0, *)
    var crs_safeAreaLeadingAnchor: NSLayoutXAxisAnchor {
        return crs_safeAreaLayoutGuide?.leadingAnchor ?? leadingAnchor
    }
}
