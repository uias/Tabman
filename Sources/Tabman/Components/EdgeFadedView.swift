//
//  EdgeFadedView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 03/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal final class EdgeFadedView: UIView {
    
    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.02, 0.05, 0.95, 0.98]
        return gradientLayer
    }()
    
    var showFade: Bool = false {
        didSet {
            layer.mask = showFade ? gradientLayer : nil
        }
    }
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        superview?.layoutIfNeeded()
        
        gradientLayer.frame = self.bounds
    }
}
