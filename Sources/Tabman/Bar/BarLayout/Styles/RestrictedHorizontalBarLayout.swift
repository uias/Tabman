//
//  RestrictedHorizontalBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 26/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// Layout that displays a limited number of visible bar buttons sequentially along the horizontal axis.
open class RestrictedHorizontalBarLayout: BarLayout {
    
    // MARK: Properties
    
    private let stackView = UIStackView()

    @available(*, unavailable)
    public override var contentMode: BarLayout.ContentMode {
        set {
            fatalError("\(type(of: self)) does not support updating contentMode")
        } get {
            return super.contentMode
        }
    }
    @available(*, unavailable)
    public override var isPagingEnabled: Bool {
        set {
            fatalError("\(type(of: self)) does not support updating isPagingEnabled")
        } get {
            return super.isPagingEnabled
        }
    }
   
    private var viewWidthConstraints: [NSLayoutConstraint]?
    /// The number of buttons that can be visible in the layout at one time.
    public var visibleButtonCount: Int = 5 {
        didSet {
            guard oldValue != visibleButtonCount else {
                return
            }
            constrain(views: stackView.arrangedSubviews, for: visibleButtonCount)
        }
    }
    
    // MARK: Lifecycle
    
    open override func performLayout(in view: UIView) {
        super.performLayout(in: view)
    
        stackView.distribution = .fill
        super.isPagingEnabled = true
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    open override func insert(buttons: [BarButton], at index: Int) {
        var currentIndex = index
        
        for button in buttons {
            if index >= stackView.arrangedSubviews.count { // just add
                stackView.addArrangedSubview(button)
            } else {
                stackView.insertArrangedSubview(button, at: currentIndex)
            }
            currentIndex += 1
        }
        constrain(views: buttons, for: visibleButtonCount)
    }
    
    open override func remove(buttons: [BarButton]) {
        for button in buttons {
            stackView.removeArrangedSubview(button)
        }
    }
    
    open override func focusArea(for position: CGFloat, capacity: Int) -> CGRect {
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
                      height: view.bounds.size.height)
    }
}

private extension RestrictedHorizontalBarLayout {
    
    func constrain(views: [UIView], for maximumCount: Int) {
        if let oldConstraints = viewWidthConstraints {
            NSLayoutConstraint.deactivate(oldConstraints)
        }
        
        var constraints = [NSLayoutConstraint]()
        let multiplier = 1.0 / CGFloat(maximumCount)
        for view in views {
            constraints.append(view.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor,
                                                           multiplier: multiplier))
        }
        NSLayoutConstraint.activate(constraints)
        self.viewWidthConstraints = constraints
    }
}
