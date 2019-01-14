//
//  TMConstrainedHorizontalBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 26/06/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

/// Layout that displays bar buttons sequentially along the horizontal axis, but is constrained by the number of items it can display.
///
/// Based on `TMHorizontalBarLayout`. If the bar happens to contain more bar buttons than the `visibleButtonCount`, they will be off screen.
/// You should use this layout if you want to a horizontal layout with a limited amount of buttons, such as a tab bar.
/// It's also worth noting that the button width is set to `bounds.size.width / visibleButtonCount` rather than using intrinsic sizing.
open class TMConstrainedHorizontalBarLayout: TMHorizontalBarLayout {
    
    // MARK: Properties
    
    @available(*, unavailable)
    open override var contentMode: TMBarLayout.ContentMode {
        set {
            fatalError("\(type(of: self)) does not support updating contentMode")
        } get {
            return super.contentMode
        }
    }
    @available(*, unavailable)
    open override var interButtonSpacing: CGFloat {
        set {
            fatalError("\(type(of: self)) does not support updating interButtonSpacing")
        } get {
            return super.interButtonSpacing
        }
    }
   
    private var viewWidthConstraints: [NSLayoutConstraint]?
    /// The number of buttons to be visible in the layout.
    ///
    /// If the number of buttons exceeds this value, paging will be enabled.
    open var visibleButtonCount: Int = 5 {
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
        super.interButtonSpacing = 0.0
    }
    
    open override func insert(buttons: [TMBarButton], at index: Int) {
        super.insert(buttons: buttons, at: index)
        
        // Constrain button widths to visible count on insertion
        constrain(views: stackView.arrangedSubviews, for: visibleButtonCount)
    }
}

private extension TMConstrainedHorizontalBarLayout {
    
    func constrain(views: [UIView], for maximumCount: Int) {
        if let oldConstraints = viewWidthConstraints {
            NSLayoutConstraint.deactivate(oldConstraints)
        }
        
        var constraints = [NSLayoutConstraint]()
        let multiplier = 1.0 / CGFloat(min(maximumCount, views.count))
        for view in views {
            constraints.append(view.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor,
                                                           multiplier: multiplier))
        }
        NSLayoutConstraint.activate(constraints)
        self.viewWidthConstraints = constraints
    }
}
