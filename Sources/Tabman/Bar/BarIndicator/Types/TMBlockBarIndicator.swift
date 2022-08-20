//
//  TMBlockBarIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/11/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

/// Indicator that fills the bar, displaying a solid color.
open class TMBlockBarIndicator: TMBarIndicator {
    
    // MARK: Types
    
    public enum CornerStyle {
        case square
        case rounded
        case eliptical
    }
    
    // MARK: Properties
    
    open override var displayMode: TMBarIndicator.DisplayMode {
        return .fill
    }
    
    // MARK: Customization
    
    /// Corner style for the indicator.
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
        
        self.backgroundColor = tintColor.withAlphaComponent(0.25)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        superview?.layoutIfNeeded()
        layer.cornerRadius = cornerStyle.cornerRadius(for: bounds)
    }
}

private extension TMBlockBarIndicator.CornerStyle {
    
    func cornerRadius(for frame: CGRect) -> CGFloat {
        switch self {
        case .square:
            return 0.0
        case .rounded:
            return frame.size.height / 6.0
        case .eliptical:
            return frame.size.height / 2.0
        }
    }
}
