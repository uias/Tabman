//
//  UIScrollView+Interaction.swift
//  Tabman
//
//  Created by Merrick Sapsford on 10/07/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal extension UIScrollView {
    
    /// Whether the scroll view is currently experiencing interaction of any kind.
    var isBeingInteracted: Bool {
        return isDragging || isDecelerating || isTracking || isZooming
    }
}
