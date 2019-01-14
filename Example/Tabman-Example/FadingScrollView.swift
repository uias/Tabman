//
//  FadingScrollView.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 17/10/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

final class FadingScrollView: UIScrollView {
    
    private struct Defaults {
        static let topStartLocation: CGFloat = 0.02
        static let topEndLocation: CGFloat = 0.2
        static let bottomEndLocation: CGFloat = 0.8
        static let bottomStartLocation: CGFloat = 0.98
    }
    
    // MARK: Properties
    
    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradientLayer
    }()
    
    private var scrollObserver: NSKeyValueObservation?
    
    // MARK: Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    private func initialize() {
        self.scrollObserver = observe(\.contentOffset) { [unowned self] (object, change) in
            self.updateFadeForCurrentContentOffset()
        }
        
        layer.mask = gradientLayer
    }
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        superview?.layoutIfNeeded()
        
        gradientLayer.frame = self.bounds
    }
    
    // MARK: Updates
    
    private func updateFadeForCurrentContentOffset() {
        
        let contentSizeRatio = ((contentSize.height - bounds.size.height) / 2)
        
        let topOffsetRatio = max(0.0, min(1.0, (contentOffset.y / contentSizeRatio)))
        let topStartLocation = NSNumber(value: Float(topOffsetRatio * Defaults.topStartLocation))
        let topEndLocation = NSNumber(value: Float(topOffsetRatio * Defaults.topEndLocation))
        
        let bottomOffsetRatio = max(0.0, min(1.0, ((contentSize.height - bounds.size.height) - contentOffset.y) / contentSizeRatio))
        let bottomStartLocation = NSNumber(value: Float(1.0 - (bottomOffsetRatio * (1.0 - Defaults.bottomStartLocation))))
        let bottomEndLocation = NSNumber(value: Float(1.0 - (bottomOffsetRatio * (1.0 - Defaults.bottomEndLocation))))
        
        gradientLayer.locations = [topStartLocation, topEndLocation, bottomEndLocation, bottomStartLocation]
    }
}
