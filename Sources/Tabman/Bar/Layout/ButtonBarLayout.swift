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
    
    private let stackView = ScrollStackView()
    private var itemWidthConstraints: [Constraint]?
    
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
        updateLayoutConstraintsForFreshLayout()
    }
    
    override func clear() {
        stackView.arrangedSubviews.forEach({ stackView.removeArrangedSubview($0) })
    }
}

// MARK: - Customization
public extension ButtonBarLayout {
    
    public var interButtonSpacing: CGFloat {
        set {
            stackView.spacing = newValue
        } get {
            return stackView.spacing
        }
    }
    
    public var isScrollEnabled: Bool {
        set {
            stackView.isScrollEnabled = newValue
            updateLayoutConstraintsFor(isScrollEnabled: newValue)
        } get {
            return stackView.isScrollEnabled
        }
    }
}

// MARK: - Layout Updating
private extension ButtonBarLayout {
    
    /// Apply any layout constraint changes that are required for the
    /// current customization state to a fresh layout (From `populate()`).
    private func updateLayoutConstraintsForFreshLayout() {
        
        if self.isScrollEnabled != true { // Default state is fine with true
            updateLayoutConstraintsFor(isScrollEnabled: isScrollEnabled)
        }
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
            guard itemWidthConstraints == nil else {
                return
            }
            
            let constrainedWidth = container.frame.size.width / CGFloat(stackView.arrangedSubviews.count)
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
