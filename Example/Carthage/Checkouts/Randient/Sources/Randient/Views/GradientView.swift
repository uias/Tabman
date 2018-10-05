//
//  GradientView.swift
//  Randient
//
//  Created by Merrick Sapsford on 09/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// View which displays a gradient layer in its bounds.
open class GradientView: UIView {
    
    // MARK: Properties
    
    private var gradientLayer: CAGradientLayer? {
        get {
            if let gradientLayer = self.layer as? CAGradientLayer {
                return gradientLayer
            }
            return nil
        }
    }
    
    /// The colors that are currently active in the gradient. Animatable.
    open private(set) var colors: [UIColor]? = nil {
        didSet {
            var colorRefs = [CGColor]()
            for color in colors ?? [] {
                colorRefs.append(color.cgColor)
            }
            gradientLayer?.colors = colorRefs
        }
    }
    
    /// Locations of each gradient stop. Animatable.
    open var locations: [Double]? = nil {
        didSet {
            var locationNumbers = [NSNumber]()
            for location in locations ?? [] {
                locationNumbers.append(NSNumber(value: location))
            }
            gradientLayer?.locations = locationNumbers
        }
    }
    
    /// The start point of the gradient in the layers coordinate space. Animiatable.
    open var startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0) {
        didSet {
            gradientLayer?.startPoint = startPoint
        }
    }
    /// The end point of the gradient in the layers coordinate space. Animiatable.
    open var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0) {
        didSet {
            gradientLayer?.endPoint = endPoint
        }
    }
    
    open override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    // MARK: Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        self.colors = [UIColor.white, UIColor.black]
        gradientLayer?.startPoint = self.startPoint
        gradientLayer?.endPoint = self.endPoint
    }
    
    // MARK: Customization
    
    /// Update the colors of the gradient.
    ///
    /// - Parameters:
    ///   - colors: New colors.
    ///   - animated: Whether to animate the update.
    ///   - duration: Duration of the animation.
    ///   - completion: Completion handler.
    internal func setColors(_ colors: [UIColor],
                            animated: Bool,
                            duration: TimeInterval = 1.0,
                            completion: (() -> Void)?) {
        
        // Equalize colors
        self.colors = equalize(colors: self.colors, with: colors)
        let fromColors = gradientLayer?.colors
        self.colors = equalize(colors: colors, with: self.colors)
        
        if animated {
            
            CATransaction.begin()
            
            let animation = CABasicAnimation(keyPath: "colors")
            animation.fromValue = fromColors
            animation.toValue = gradientLayer?.colors
            animation.duration = duration
            animation.isRemovedOnCompletion = true
            #if swift(>=4.2)
                animation.fillMode = .forwards
                animation.timingFunction = CAMediaTimingFunction(name: .linear)
            #else
                animation.fillMode = kCAFillModeForwards
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            #endif
            
            CATransaction.setCompletionBlock {
                completion?()
            }
            
            gradientLayer?.add(animation, forKey: "colors")
            CATransaction.commit()
        } else {
            completion?()
        }
    }
}

private extension GradientView {
    
    /// Ensures an array of colors is equalized with another array.
    ///
    /// Uses color interpolation to insert any missing values.
    ///
    /// - Parameters:
    ///   - colors: Colors to equalize.
    ///   - others: Colors to compare against.
    /// - Returns: Equalized colors.
    func equalize(colors: [UIColor]?, with others: [UIColor]?) -> [UIColor]? {
        guard let colors = colors, let others = others,
            let first = colors.first, let last = colors.last else {
            return nil
        }
        let delta = others.count - colors.count
        guard delta > 0 else {
            return colors
        }
        
        let interpolationPoint = 1.0 / CGFloat(delta + 1)
        var newColors = [first]
        for point in 1 ... delta {
            let percent = CGFloat(point) * interpolationPoint
            if let color = first.interpolate(between: last, percent: percent) {
                newColors.append(color)
            }
        }
        newColors.append(last)
        
        return newColors
    }
}
