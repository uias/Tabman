//
//  ConstrainedHorizontalBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 26/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// Layout that displays a limited number of visible bar buttons sequentially along the horizontal axis.
open class ConstrainedHorizontalBarLayout: HorizontalBarLayout {
    
    // MARK: Properties
    
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
    
    open override func layout(in view: UIView) {
        super.layout(in: view)
        super.isPagingEnabled = true
    }
    
    open override func insert(buttons: [BarButton], at index: Int) {
        super.insert(buttons: buttons, at: index)
        constrain(views: buttons, for: visibleButtonCount)
    }
}

private extension ConstrainedHorizontalBarLayout {
    
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
