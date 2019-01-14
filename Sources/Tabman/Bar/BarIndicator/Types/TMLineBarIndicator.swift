//
//  TMLineBarIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 07/06/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

/// Simple indicator that displays as a horizontal line.
open class TMLineBarIndicator: TMBarIndicator {
    
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
    
    private var weightConstraint: NSLayoutConstraint?
    
    open override var displayMode: TMBarIndicator.DisplayMode {
        return .bottom
    }

    // MARK: Customization
    
    /// Color of the line.
    open override var tintColor: UIColor! {
        didSet {
            backgroundColor = tintColor
        }
    }
    /// Weight of the line.
    ///
    /// Options:
    /// - light: 2.0 pt
    /// - medium: 4.0 pt
    /// - heavy: 8.0 pt
    /// - custom: Custom weight.
    ///
    /// Default: `.medium`
    open var weight: Weight = .medium {
        didSet {
            weightConstraint?.constant = weight.rawValue
            setNeedsLayout()
        }
    }
    /// Corner style for the ends of the line.
    ///
    /// Options:
    /// - square: Corners are squared off.
    /// - rounded: Corners are rounded.
    /// - eliptical: Corners are completely circular.
    ///
    /// Default: `.square`.
    open var cornerStyle: CornerStyle = .square {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: Lifecycle
    
    open override func layout(in view: UIView) {
        super.layout(in: view)
        
        let heightConstraint = heightAnchor.constraint(equalToConstant: weight.rawValue)
        heightConstraint.isActive = true
        self.weightConstraint = heightConstraint
        
        backgroundColor = self.tintColor
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        superview?.layoutIfNeeded()
        layer.cornerRadius = cornerStyle.cornerRadius(for: weight.rawValue,
                                                      in: bounds)
    }
}

private extension TMLineBarIndicator.Weight {
    
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

private extension TMLineBarIndicator.CornerStyle {
    
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
