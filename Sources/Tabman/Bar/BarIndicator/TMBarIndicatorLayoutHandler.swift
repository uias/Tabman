//
//  TMBarIndicatorLayoutHandler.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/06/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

/// Layout handler that updates a `TMBarIndicator` layout constraints for a new focus rect.
internal final class TMBarIndicatorLayoutHandler {
    
    // MARK: Properties
    
    private let leading: NSLayoutConstraint?
    private let width: NSLayoutConstraint?
    
    // MARK: Init
    
    init(leading: NSLayoutConstraint?,
         width: NSLayoutConstraint?) {
        self.leading = leading
        self.width = width
    }
    
    // MARK: Updates
    
    func update(for rect: CGRect) {
        self.leading?.constant = rect.minX
        self.width?.constant = rect.size.width
    }
}
