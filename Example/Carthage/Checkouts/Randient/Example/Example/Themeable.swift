//
//  Themeable.swift
//  Example
//
//  Created by Merrick Sapsford on 18/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

enum Theme {
    case light
    case dark
}

protocol Themeable {
    
    func applyTheme(_ theme: Theme)
}

extension Themeable where Self: UIViewController {
    
    func applyTheme(_ theme: Theme) {
        applyTheme(theme, to: self.view, animated: true)
    }
    
    func applyTheme(_ theme: Theme, animated: Bool) {
        applyTheme(theme, to: self.view, animated: animated)
    }
    
    private func applyTheme(_ theme: Theme, to view: UIView, animated: Bool) {
        for subview in view.subviews {
            applyTheme(theme, to: subview, animated: animated)
        }
        
        if let themeableView = view as? Themeable {
            if animated {
                UIView.transition(with: view, duration: 1.0, options: .transitionCrossDissolve, animations: {
                    themeableView.applyTheme(theme)
                }, completion: nil)
            } else {
                themeableView.applyTheme(theme)
            }
        }
    }
}
