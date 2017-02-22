//
//  TabmanLineIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 20/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class TabmanLineIndicator: UIView {
    
    //
    // MARK: Types
    //
    
    /// Weight of the indicator line.
    ///
    /// - thin: Thin - 1pt
    /// - normal: Normal - 2pt
    /// - thick: Thick - 4pt
    enum Weight: CGFloat {
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
    var weight: Weight = .normal {
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
    var useRoundedCorners: Bool = false {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The color of the indicator line.
    override var tintColor: UIColor! {
        didSet {
            self.backgroundColor = tintColor
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: self.weight.rawValue)
    }
    
    //
    // MARK: Init
    //
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initIndicator()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initIndicator()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    func initIndicator() {
        self.backgroundColor = self.tintColor
    }
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layoutIfNeeded()
        self.layer.cornerRadius = useRoundedCorners ? self.bounds.size.height / 2.0 : 0.0
    }
}
