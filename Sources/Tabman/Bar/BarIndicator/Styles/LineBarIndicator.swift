//
//  LineBarIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 07/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public final class LineBarIndicator: BarIndicator {
    
    // MARK: Types
    
    public enum Weight {
        case light
        case medium
        case heavy
        case custom(value: CGFloat)
    }
    
    // MARK: Properties
    
    public override var displayStyle: BarIndicator.DisplayStyle {
        return .footer
    }
    
    public var weight: Weight = .medium {
        didSet {
            weightConstraint?.constant = weight.rawValue
            setNeedsLayout()
        }
    }
    private var weightConstraint: NSLayoutConstraint?
    
    // MARK: Lifecycle
    
    public override func performLayout(in view: UIView) {
        super.performLayout(in: view)
        
        let heightConstraint = heightAnchor.constraint(equalToConstant: weight.rawValue)
        heightConstraint.isActive = true
        self.weightConstraint = heightConstraint
    }
}

private extension LineBarIndicator.Weight {
    
    var rawValue: CGFloat {
        switch self {
        case .light:
            return 2.0
        case .medium:
            return 4.0
        case .heavy:
            return 8.0
        case .custom(let value):
            return value
        }
    }
}
