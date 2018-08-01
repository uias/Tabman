//
//  ButtonBarViewLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

public final class ButtonBarViewLayout: BarViewLayout {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let interButtonSpacing: CGFloat = 8.0
        static let minimumRecommendedButtonWidth: CGFloat = 40.0
    }
    
    // MARK: Properties
    
    private let stackView = UIStackView()
    private var itemWidthConstraints: [Constraint]?
    
    public override var contentMode: BarViewLayout.ContentMode {
        didSet {
            switch contentMode {
            case .fill:
                buttonDistribution = .fill
            case .fit:
                buttonDistribution = .fillEqually
            }
        }
    }
    
    // MARK: Layout
    
    public override func performLayout(in view: UIView) {
        super.performLayout(in: view)
        
        container.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.interButtonSpacing = Defaults.interButtonSpacing
    }
    
    // MARK: Lifecycle
    
    override func populate(with barButtons: [BarButton]) {
        barButtons.forEach({ stackView.addArrangedSubview($0) })
    }
    
    override func clear() {
        stackView.arrangedSubviews.forEach({ stackView.removeArrangedSubview($0) })
    }
    
    // MARK: BarFocusProvider
    
    override func barFocusRect(for position: CGFloat, capacity: Int) -> CGRect {
        let range = BarMath.localIndexRange(for: position, minimum: 0, maximum: capacity - 1)
        guard stackView.arrangedSubviews.count > range.upperBound else {
            return .zero
        }
        
        let lowerView = stackView.arrangedSubviews[range.lowerBound]
        let upperView = stackView.arrangedSubviews[range.upperBound]
        
        let progress = BarMath.localProgress(for: position)
        let interpolation = lowerView.frame.interpolate(with: upperView.frame, progress: progress)
        
        return CGRect(x: lowerView.frame.origin.x + interpolation.origin.x,
                      y: 0.0,
                      width: lowerView.frame.size.width + interpolation.size.width,
                      height: container.bounds.size.height)
    }
}

// MARK: - Customization
public extension ButtonBarViewLayout {
    
    public var interButtonSpacing: CGFloat {
        set {
            stackView.spacing = newValue
        } get {
            return stackView.spacing
        }
    }
    
    private var buttonDistribution: UIStackView.Distribution {
        set {
            stackView.distribution = newValue
        } get {
            return stackView.distribution
        }
    }
}
