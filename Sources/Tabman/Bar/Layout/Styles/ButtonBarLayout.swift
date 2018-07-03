//
//  ButtonBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

public final class ButtonBarLayout: BarLayout {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let interButtonSpacing: CGFloat = 8.0
        static let minimumRecommendedButtonWidth: CGFloat = 40.0
    }
    
    // MARK: Properties
    
    private let stackView = UIStackView()
    private var itemWidthConstraints: [Constraint]?
    
    public var isScrollEnabled: Bool = true {
        didSet {
            updateLayoutConstraintsFor(isScrollEnabled: isScrollEnabled)
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
        invalidateStateLayoutConstraints()
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
public extension ButtonBarLayout {
    
    public var interButtonSpacing: CGFloat {
        set {
            stackView.spacing = newValue
            invalidateStateLayoutConstraints()
        } get {
            return stackView.spacing
        }
    }
}

// MARK: - Layout Updating
private extension ButtonBarLayout {
    
    /// Apply any layout constraint changes that are required for the
    /// current customization state.
    private func invalidateStateLayoutConstraints() {
        
        updateLayoutConstraintsFor(isScrollEnabled: isScrollEnabled)
    }
    
    /// Constrain item views to fit the width of the screen if scroll is disabled.
    ///
    /// - Parameter isScrollEnabled: Whether scroll is enabled.
    private func updateLayoutConstraintsFor(isScrollEnabled: Bool) {
        if isScrollEnabled {
            
            for constraint in itemWidthConstraints ?? [] {
                constraint.deactivate()
            }
            self.itemWidthConstraints = nil
            
        } else {
            if let itemWidthConstraints = self.itemWidthConstraints {
                itemWidthConstraints.forEach({ $0.deactivate() })
            }
            container.layoutIfNeeded()

            let itemCount = CGFloat(stackView.arrangedSubviews.count)
            let totalInterItemSpacing = interButtonSpacing * (itemCount - 1.0)
            let constrainedWidth = (presentingBounds.size.width - totalInterItemSpacing) / itemCount
            
            if constrainedWidth < Defaults.minimumRecommendedButtonWidth {
                print("The item width in the ButtonBarLayout is less than \(Defaults.minimumRecommendedButtonWidth) when `isScrollEnabled = false`. It is recommended that you enable scrolling to avoid interaction issues.")
            }
            
            var constraints = [Constraint]()
            for view in stackView.arrangedSubviews {
                view.snp.makeConstraints { (make) in
                    constraints.append(make.width.equalTo(max(constrainedWidth, 0.0)).constraint)
                }
            }
            self.itemWidthConstraints = constraints
        }
    }
}
