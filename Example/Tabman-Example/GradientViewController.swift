//
//  GradientViewController.swift
//  Pageboy-Example
//
//  Created by Merrick Sapsford on 18/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

class GradientViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private var gradientView: GradientView!
    
    var gradients: [Gradient]? {
        didSet {
            update(for: gradientOffset)
        }
    }
    
    var gradientOffset: CGFloat = 0.0 {
        didSet {
            update(for: gradientOffset)
        }
    }
    
    var activeColors: [UIColor]? {
        return gradientView.colors
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return children.first
    }
    override var childForStatusBarHidden: UIViewController? {
        return children.first
    }
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: Updating
    
    private func update(for offset: CGFloat) {
        var sanitizedOffset = offset
        if sanitizedOffset < 0.0 {
            sanitizedOffset = 1.0 + sanitizedOffset
        }
        
        var integral: Double = 0.0
        let percentage = CGFloat(modf(Double(sanitizedOffset), &integral))
        let lowerIndex = Int(floor(offset))
        let upperIndex = Int(ceil(offset))
        
        let lowerGradient = gradient(for: lowerIndex)
        let upperGradient = gradient(for: upperIndex)
        
        if let top = lowerGradient.top.interpolate(between: upperGradient.top, percent: percentage),
            let bottom = lowerGradient.bottom.interpolate(between: upperGradient.bottom, percent: percentage) {
            gradientView.colors = [top, bottom]
        }
    }
    
    private func gradient(for index: Int) -> Gradient {
        guard let gradients = self.gradients, index >= 0 && index < gradients.count else {
            return .defaultGradient
        }
        
        return gradients[index]
    }
}
