//
//  CircularBarActionButton.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 08/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

final class CircularBarActionButton: UIControl {
    
    // MARK: Types
    
    enum Action: String {
        case add = "+"
        case delete = "-"
    }
    
    // MARK: Defaults
    
    private struct Defaults {
        static let circleSize = CGSize(width: 26, height: 26)
    }
    
    // MARK: Properties
    
    let action: Action
    private let shapeLayer = CAShapeLayer()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 40.0, height: 40.0)
    }
    
    // MARK: Init
    
    init(action: Action) {
        self.action = action
        super.init(frame: .zero)
        initialize()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func initialize() {
        
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true

        shapeLayer.backgroundColor = tintColor.cgColor
        layer.addSublayer(shapeLayer)
    }
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        superview?.layoutIfNeeded()
        
        shapeLayer.bounds.size = Defaults.circleSize
        shapeLayer.frame.origin = CGPoint(x: (bounds.size.width - Defaults.circleSize.width) / 2,
                                          y: (bounds.size.height - Defaults.circleSize.height) / 2)
        shapeLayer.cornerRadius = shapeLayer.bounds.size.width / 2
        
    }
}
