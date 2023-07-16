//
//  TMChevronBarIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 01/11/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

/// Indicator that displays a vertical chevron centered along the X-axis.
open class TMChevronBarIndicator: TMBarIndicator {
    
    // MARK: Types
    
    public enum Size {
        case small
        case medium
        case large
        case custom(size: CGSize)
    }
    
    // MARK: Properties
    
    private let chevronContainer = UIView()
    private let chevronLayer = CAShapeLayer()
    
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    open override var displayMode: TMBarIndicator.DisplayMode {
        return .bottom
    }
    
    // MARK: Customization
    
    /// Size of the chevron.
    ///
    /// Options:
    /// - small: (10 x 8pt)
    /// - medium: (14 x 12pt)
    /// - large: (20 x 16pt)
    /// - custom: A custom size.
    open var size: Size = .medium {
        didSet {
            guard size.rawValue != oldValue.rawValue else {
                return
            }
            update(for: size.rawValue)
        }
    }
    /// Color of the chevron.
    open override var tintColor: UIColor! {
        didSet {}
    }
    
    // MARK: Lifecycle
    
    open override func layout(in view: UIView) {
        super.layout(in: view)
        
        view.addSubview(chevronContainer)
        chevronContainer.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = chevronContainer.widthAnchor.constraint(equalToConstant: size.rawValue.width)
        let heightConstraint = chevronContainer.heightAnchor.constraint(equalToConstant: size.rawValue.height)
        NSLayoutConstraint.activate([
            chevronContainer.topAnchor.constraint(equalTo: topAnchor),
            chevronContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            chevronContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            widthConstraint,
            heightConstraint
            ])
        self.widthConstraint = widthConstraint
        self.heightConstraint = heightConstraint
        
        chevronLayer.fillColor = tintColor.cgColor
        chevronContainer.layer.addSublayer(chevronLayer)
    }

    open override func tintColorDidChange() {
        super.tintColorDidChange()
        chevronLayer.fillColor = tintColor.cgColor
    }
    
    // MARK: Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        chevronLayer.frame = chevronContainer.bounds
        chevronLayer.path = chevronPath(for: size.rawValue).cgPath
    }
    
    private func update(for size: CGSize) {
        widthConstraint?.constant = size.width
        heightConstraint?.constant = size.height
        setNeedsLayout()
    }
}

private extension TMChevronBarIndicator {
    
    func chevronPath(for size: CGSize) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: size.height))
        path.addLine(to: CGPoint(x: size.width / 2, y: 0.0))
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        path.close()
        return path
    }
}

private extension TMChevronBarIndicator.Size {
    
    var rawValue: CGSize {
        switch self {
        case .small:
            return CGSize(width: 10, height: 8)
        case .medium:
            return CGSize(width: 14, height: 12)
        case .large:
            return CGSize(width: 20, height: 16)
        case .custom(let size):
            return size
        }
    }
}
