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
 
    // MARK: Properties
    
    @available(*, unavailable)
    public override var contentMode: BarLayout.ContentMode {
        set {
            fatalError("\(type(of: self)) does not support updating contentMode")
        } get {
            return super.contentMode
        }
    }
    @available(*, unavailable)
    public override var isPagingEnabled: Bool {
        set {
            fatalError("\(type(of: self)) does not support updating isPagingEnabled")
        } get {
            return super.isPagingEnabled
        }
    }
    
    // MARK: Lifecycle
    
    public override func layout(in view: UIView) {
        super.layout(in: view)
        super.contentMode = .fit
    }
    
    public override func insert(buttons: [BarButton], at index: Int) {
    }
    
    public override func remove(buttons: [BarButton]) {
    }
    
    public override func focusArea(for position: CGFloat, capacity: Int) -> CGRect {
        guard capacity != 0 else {
            return .zero
        }
        
        let viewWidth = view.bounds.size.width
        let buttonWidth = viewWidth / CGFloat(capacity)
        
        let proposedX = buttonWidth * position
        let constrainedX = max(0.0, min(proposedX, viewWidth - buttonWidth))
        
        return CGRect(x: constrainedX,
                      y: 0.0,
                      width: buttonWidth,
                      height: 0.0)
    }
}
