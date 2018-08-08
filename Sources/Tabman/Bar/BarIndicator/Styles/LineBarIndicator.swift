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
    
    public enum CornerStyle {
        case square
        case rounded
        case eliptical
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
    
    public var cornerStyle: CornerStyle = .square {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: Lifecycle
    
    public override func performLayout(in view: UIView) {
        super.performLayout(in: view)
        
        let heightConstraint = heightAnchor.constraint(equalToConstant: weight.rawValue)
        heightConstraint.isActive = true
        self.weightConstraint = heightConstraint
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        superview?.layoutIfNeeded()
        layer.cornerRadius = cornerStyle.cornerRadius(for: weight.rawValue,
                                                      in: self.bounds)
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

private extension LineBarIndicator.CornerStyle {
    
    func cornerRadius(for weight: CGFloat, in frame: CGRect) -> CGFloat {
        switch self {
        case .square:
            return 0.0
        case .rounded:
            return weight / 4.0
        case .eliptical:
            return frame.size.height / 2.0
        }
    }
}
