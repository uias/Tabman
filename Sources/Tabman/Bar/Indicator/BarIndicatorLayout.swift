//
//  BarIndicatorLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal final class BarIndicatorLayout {
    
    // MARK: Properties
    
    private let leading: NSLayoutConstraint?
    private let width: NSLayoutConstraint?
    private let height: NSLayoutConstraint?
    
    // MARK: Init
    
    init(leading: NSLayoutConstraint?,
         width: NSLayoutConstraint?,
         height: NSLayoutConstraint?) {
        self.leading = leading
        self.width = width
        self.height = height
    }
    
    // MARK: Updates
    
    func update(for rect: CGRect) {
        self.leading?.constant = rect.minX
        self.width?.constant = rect.size.width
        self.height?.constant = 10
    }
}
