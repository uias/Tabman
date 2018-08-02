//
//  BarViewFocusProvider.swift
//  Tabman
//
//  Created by Merrick Sapsford on 07/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// An object that can provide focus related positional data to a BarView.
public protocol BarViewFocusProvider: class {
    
    /**
     Calculate the 'focusRect' for the current position and capacity.
     
     This rect defines the area of the layout that should currently be highlighted for the selected bar button.
     
     - Parameter position: Current position to display.
     - Parameter capacity: Capacity of the bar (items).
     
     - Returns: Calculated focus rect.
     **/
    func barFocusRect(for position: CGFloat, capacity: Int) -> CGRect
}
