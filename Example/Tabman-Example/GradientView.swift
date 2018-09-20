//
//  GradientView.swift
//  Pageboy-Example
//
//  Created by Merrick Sapsford on 15/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    
    enum Direction {
        case topToBottom
        case leftToRight
        case rightToLeft
        case bottomToTop
        case custom(start: CGPoint, end: CGPoint)
    }
    
    // MARK: Properties
    
    var gradientLayer: CAGradientLayer? {
        get {
            if let gradientLayer = self.layer as? CAGradientLayer {
                return gradientLayer
            }
            return nil
        }
    }
    
    var colors: [UIColor]? = nil {
        didSet {
            self.updateGradient()
        }
    }
    
    var locations: [Double]? = nil {
        didSet {
            self.updateGradient()
        }
    }
    
    var direction: Direction = .topToBottom {
        didSet {
            self.updateGradient()
        }
    }
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateGradient()
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    func setColors(_ colors: [UIColor], animated: Bool, duration: Double = 0.3) {
        let fromColors = self.colors
        self.colors = colors
        if animated {
            let animation = CABasicAnimation(keyPath: "colors")
            animation.fromValue = fromColors
            animation.toValue = colors
            animation.duration = duration
            animation.isRemovedOnCompletion = true
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            self.gradientLayer?.add(animation, forKey: "colors")
        }
    }
    
    // MARK: Gradient
    
    func updateGradient() {
        guard let colors = self.colors else {
            self.gradientLayer?.colors = []
            return
        }
        
        var colorRefs = [CGColor]()
        for color in colors {
            colorRefs.append(color.cgColor)
        }
        self.gradientLayer?.colors = colorRefs
        
        if let locations = self.locations {
            var locationNumbers = [NSNumber]()
            for location in locations {
                locationNumbers.append(NSNumber(value: location))
            }
            self.gradientLayer?.locations = locationNumbers
        }
        
        switch self.direction {
        case .topToBottom:
            self.gradientLayer?.startPoint = CGPoint(x: 0.5, y: 0.0)
            self.gradientLayer?.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .leftToRight:
            self.gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.5)
            self.gradientLayer?.endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .rightToLeft:
            self.gradientLayer?.startPoint = CGPoint(x: 1.0, y: 0.5)
            self.gradientLayer?.endPoint = CGPoint(x: 0.0, y: 0.5)
            
        case .bottomToTop:
            self.gradientLayer?.startPoint = CGPoint(x: 0.5, y: 1.0)
            self.gradientLayer?.endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .custom(let start, let end):
            gradientLayer?.startPoint = start
            gradientLayer?.endPoint = end
        }
    }
}
