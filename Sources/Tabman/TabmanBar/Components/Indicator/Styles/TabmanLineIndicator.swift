//
//  TabmanLineIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 20/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public extension TabmanIndicator {
    
    /// Weight of the indicator line.
    ///
    /// - thin: Thin - 1pt
    /// - normal: Normal - 2pt
    /// - thick: Thick - 4pt
    public enum LineWeight: CGFloat {
        case thin = 1.0
        case normal = 2.0
        case thick = 4.0
    }
}

internal class TabmanLineIndicator: TabmanIndicator {
    
    //
    // MARK: Properties
    //
    
    /// The thickness of the indicator line.
    ///
    /// Default is .normal
    public var weight: LineWeight = TabmanBar.Appearance.defaultAppearance.indicator.lineWeight ?? .normal {
        didSet {
            guard weight != oldValue else {
                return
            }
            self.invalidateIntrinsicContentSize()
            self.superview?.setNeedsLayout()
            self.superview?.layoutIfNeeded()
            
            self.delegate?.indicator(requiresLayoutInvalidation: self)
        }
    }
    
    /// Whether to use rounded corners for the indicator line.
    ///
    /// Default is false
    public var useRoundedCorners: Bool = TabmanBar.Appearance.defaultAppearance.indicator.useRoundedCorners ?? false {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The color of the indicator line.
    override public var tintColor: UIColor! {
        didSet {
            self.backgroundColor = tintColor
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: self.weight.rawValue)
    }
    
    //
    // MARK: Lifecycle
    //
    
    public override func constructIndicator() {
        
        self.tintColor = TabmanBar.Appearance.defaultAppearance.indicator.color
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.layoutIfNeeded()
        self.layer.cornerRadius = useRoundedCorners ? self.bounds.size.height / 2.0 : 0.0
    }
    
    override func itemTransitionType() -> TabmanItemTransition.Type? {
        return TabmanItemColorCrossfadeTransition.self
    }
}
