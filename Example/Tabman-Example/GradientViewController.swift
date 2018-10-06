//
//  GradientViewController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 18/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Randient

class GradientViewController: UIViewController {
    
    private struct Defaults {
        static let startPoint = CGPoint(x: 0.5, y: 0.0)
        static let endPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
    // MARK: Properties
    
    @IBOutlet private var gradientView: RandientView!
    
    /// Offset to adjust the gradient start / end points.
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientView.startPoint = Defaults.startPoint
        gradientView.endPoint = Defaults.endPoint
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: Updating
    
    private func update(for offset: CGFloat) {
        
        let defaultStartPoint = Defaults.startPoint
        let defaultEndPoint = Defaults.endPoint
        
        let gradientPointOffset = (offset / 2)
        gradientView.startPoint = CGPoint(x: defaultStartPoint.x - (defaultStartPoint.x * gradientPointOffset),
                                          y: -gradientPointOffset)
        gradientView.endPoint = CGPoint(x: defaultEndPoint.x + (defaultEndPoint.x * gradientPointOffset),
                                        y: defaultEndPoint.y + (defaultEndPoint.y * gradientPointOffset))
    }
}
