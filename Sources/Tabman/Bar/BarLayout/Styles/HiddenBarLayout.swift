//
//  HiddenBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 29/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// Layout that is zero height and hidden.
public final class HiddenBarLayout: BarLayout {
 
    // MARK: Lifecycle
    
    public override func performLayout(in view: UIView) {
        super.performLayout(in: view)
        
        // TODO - Make this appear
    }
    
    public override func insert(buttons: [BarButton], at index: Int) {
    }
    
    public override func remove(buttons: [BarButton]) {
    }
    
    public override func focusArea(for position: CGFloat, capacity: Int) -> CGRect {
        let viewWidth = view.bounds.size.width
        let buttonWidth = viewWidth / CGFloat(capacity)
        guard !buttonWidth.isNaN else { // 0 / 0
            return .zero
        }
        
        let proposedX = buttonWidth * position
        
        return CGRect(x: max(0.0, min(proposedX, viewWidth - buttonWidth)),
                      y: 0.0,
                      width: buttonWidth,
                      height: 0.0)
    }
}
