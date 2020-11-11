//
//  TMConstrainedHorizontalBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 26/06/2018.
//  Copyright © 2020 UI At Six. All rights reserved.
//

import UIKit

/// Layout that displays bar buttons sequentially along the horizontal axis, but is constrained by the number of items it can display.
///
/// Based on `TMHorizontalBarLayout`. If the bar happens to contain more bar buttons than the `visibleButtonCount`, they will be off screen.
/// You should use this layout if you want to a horizontal layout with a limited amount of buttons, such as a tab bar.
/// It's also worth noting that the button width is set to `bounds.size.width / visibleButtonCount` rather than using intrinsic sizing.
open class TMConstrainedHorizontalBarLayout: TMHorizontalBarLayout {
    
    // MARK: Properties
    
    // swiftlint:disable unused_setter_value
    @available(*, unavailable)
    open override var contentMode: TMBarLayout.ContentMode {
        get {
            return super.contentMode
        }
        set {
            fatalError("\(type(of: self)) does not support updating contentMode")
        }
    }
    
    // swiftlint:disable unused_setter_value
    @available(*, unavailable)
    open override var interButtonSpacing: CGFloat {
        get {
            return super.interButtonSpacing
        }
        set {
            fatalError("\(type(of: self)) does not support updating interButtonSpacing")
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
            let stackViews = Array(self.stackViews.values)
            constrainArrangedSubviews(in: stackViews, for: visibleButtonCount)
        }
    }
    
    // MARK: Init
    
    /// :nodoc:
    public required init() {
        super.init()
        
        super.interButtonSpacing = 0.0
    }
    
    // MARK: Lifecycle
    
    open override func insert(buttons: [TMBarButton], at index: Int, in area: TMBarLayout.LayoutArea) {
        super.insert(buttons: buttons, at: index, in: area)
        
        
        switch area {
        case .main:
            // Constrain button widths to visible count on insertion
            let stackViews = Array(self.stackViews.values)
            constrainArrangedSubviews(in: stackViews, for: visibleButtonCount)
            
        default:
            break
        }
    }
}

private extension TMConstrainedHorizontalBarLayout {
    
    func constrainArrangedSubviews(in stackViews: [UIStackView], for maximumCount: Int) {
        stackViews.forEach({ constrain(views: $0.arrangedSubviews, for: maximumCount) })
    }
    
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
