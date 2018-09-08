
//
//  HiddenBarIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 29/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// Indicator that is zero height and hidden.
public final class HiddenBarIndicator: BarIndicator {
    
    // MARK: Properties
    
    public override var displayStyle: BarIndicator.DisplayStyle {
        return .fill
    }
    
    public override var isHidden: Bool {
        set {
            super.isHidden = true
        } get {
            return super.isHidden
        }
    }
    
    // MARK: Lifecycle
    
    public override func layout(in view: UIView) {
        super.layout(in: view)
        
        super.isHidden = true
    }
}
