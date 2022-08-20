//
//  TMDotBarIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 07/11/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

/// Indicator that displays a circular dot centered along the X-axis.
open class TMDotBarIndicator: TMBarIndicator {
    
    // MARK: Types
    
    public enum Size {
        case small
        case medium
        case large
        case custom(size: CGSize)
    }
    
    // MARK: Properties
    
    private let dotContainer = UIView()
    private let dotLayer = CAShapeLayer()
    
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    open override var displayMode: TMBarIndicator.DisplayMode {
        return .bottom
    }
    
    // MARK: Customization
    
    open var size: Size = .medium {
        didSet {
            guard size.rawValue != oldValue.rawValue else {
                return
            }
            update(for: size.rawValue)
        }
    }
    /// Color of the dot.
    open override var tintColor: UIColor! {
        didSet {
            dotLayer.fillColor = tintColor.cgColor
        }
    }
    
    // MARK: Lifecycle
    
    open override func layout(in view: UIView) {
        super.layout(in: view)
        
        view.addSubview(dotContainer)
        dotContainer.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = dotContainer.widthAnchor.constraint(equalToConstant: size.rawValue.width)
        let heightConstraint = dotContainer.heightAnchor.constraint(equalToConstant: size.rawValue.height)
        NSLayoutConstraint.activate([
            dotContainer.topAnchor.constraint(equalTo: topAnchor),
            dotContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            dotContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            widthConstraint,
            heightConstraint
            ])
        self.widthConstraint = widthConstraint
        self.heightConstraint = heightConstraint
        
        dotLayer.fillColor = tintColor.cgColor
        dotContainer.layer.addSublayer(dotLayer)
    }
    
    // MARK: Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        dotLayer.frame = dotContainer.bounds
        dotLayer.path = dotPath(for: size.rawValue).cgPath
    }
    
    private func update(for size: CGSize) {
        widthConstraint?.constant = size.width
        heightConstraint?.constant = size.height
        setNeedsLayout()
    }
}

private extension TMDotBarIndicator {
    
    func dotPath(for size: CGSize) -> UIBezierPath {
        let path = UIBezierPath(ovalIn: CGRect(x: 0.0,
                                               y: 0.0,
                                               width: size.width,
                                               height: size.height))
        return path
    }
}

private extension TMDotBarIndicator.Size {
    
    var rawValue: CGSize {
        switch self {
        case .small:
            return CGSize(width: 6, height: 6)
        case .medium:
            return CGSize(width: 8, height: 8)
        case .large:
            return CGSize(width: 12, height: 12)
        case .custom(let size):
            return size
        }
    }
}
