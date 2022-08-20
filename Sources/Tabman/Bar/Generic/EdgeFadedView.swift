//
//  EdgeFadedView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 03/08/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

internal final class EdgeFadedView: UIView {
    
    private struct Defaults {
        static let leadingStartLocation: CGFloat = 0.02
        static let leadingEndLocation: CGFloat = 0.05
        static let trailingEndLocation: CGFloat = 0.95
        static let trailingStartLocation: CGFloat = 0.98
    }
    
    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }()
    
    var showFade: Bool = false {
        didSet {
            updateFadeRatios()
            layer.mask = showFade ? gradientLayer : nil
        }
    }
    var leadingFade: CGFloat = 1.0 {
        didSet {
            updateFadeRatios()
        }
    }
    var trailingFade: CGFloat = 1.0 {
        didSet {
            updateFadeRatios()
        }
    }
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        superview?.layoutIfNeeded()
        
        gradientLayer.frame = self.bounds
    }
    
    // MARK: Updates
    
    private func updateFadeRatios() {
        
        let leadingStartLocation = NSNumber(value: Float(Defaults.leadingStartLocation * leadingFade))
        let leadingEndLocation = NSNumber(value: Float(Defaults.leadingEndLocation * leadingFade))
        let trailingEndLocation = NSNumber(value: Float(1.0 - ((1.0 - Defaults.trailingEndLocation) * trailingFade)))
        let trailingStartLocation = NSNumber(value: Float(1.0 - ((1.0 - Defaults.trailingStartLocation) * trailingFade)))

        gradientLayer.locations = [leadingStartLocation, leadingEndLocation,
                                   trailingEndLocation, trailingStartLocation]
    }
}
