//
//  TabmanLineIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 20/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

public class TabmanLineIndicator: TabmanIndicator {
    
    //
    // MARK: Types
    //
    
    /// Weight of the indicator line.
    ///
    /// - thin: Thin - 1pt
    /// - normal: Normal - 2pt
    /// - thick: Thick - 4pt
    public enum Weight: CGFloat {
        case thin = 1.0
        case normal = 2.0
        case thick = 4.0
    }
    
    //
    // MARK: Properties
    //
    
    /// The thickness of the indicator line.
    ///
    /// Default is .normal
    public var weight: Weight = TabmanBar.Appearance.defaultAppearance.indicator.weight ?? .normal {
        didSet {
            guard weight != oldValue else {
                return
            }
            self.invalidateIntrinsicContentSize()
            self.superview?.setNeedsLayout()
            self.superview?.layoutIfNeeded()
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
        super.constructIndicator()
        
        self.tintColor = TabmanBar.Appearance.defaultAppearance.indicator.color
        self.backgroundColor = self.tintColor
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.layoutIfNeeded()
        self.layer.cornerRadius = useRoundedCorners ? self.bounds.size.height / 2.0 : 0.0
    }
}
