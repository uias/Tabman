//
//  RandientView.swift
//  Randient
//
//  Created by Merrick Sapsford on 09/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// Gradient View that provides the ability to display random `UIGradient` gradients.
open class RandientView: GradientView {
    
    // MARK: Properties
    
    /// The currently visible gradient.
    open private(set) var gradient: UIGradient!
    
    // MARK: Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        randomize(animated: false)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        randomize(animated: false)
    }
    
    // MARK: Randomization
    
    /// Display a new randomly selected gradient.
    ///
    /// - Parameters:
    ///   - animated: Whether to animate the update.
    ///   - completion: Completion handler.
    /// - Returns: The new gradient.
    @discardableResult
    open func randomize(animated: Bool,
                        completion: (() -> Void)? = nil) -> UIGradient {
        let gradient = Randient.randomize()
        update(for: gradient,
               animated: animated,
               completion: completion)
        return gradient
    }
    
    // MARK: Updating
    
    private func update(for gradient: UIGradient,
                        animated: Bool,
                        completion: (() -> Void)?) {
        self.gradient = gradient
        setColors(gradient.data.colors,
                  animated: animated,
                  completion: completion)
    }
}
