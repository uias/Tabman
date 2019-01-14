//
//  TMBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

/// `TMBarLayout` dictates the way that BarButtons are displayed within a bar, handling layout and population.
///
/// Attention: You should not directly use `BarLayout`, but instead inherit from it or use an available subclass such as `TMHorizontalBarLayout`.
open class TMBarLayout: TMBarViewFocusProvider, TMTransitionStyleable {
    
    // MARK: Types
    
    public enum ContentMode {
        case intrinsic
        case fit
    }
    
    // MARK: Properties
    
    /// Container view which contains actual contents
    public let view = UIView()
    /// The parent of the layout.
    private weak var parent: TMBarLayoutParent!
    
    /// Layout Guides that provide inset values.
    private weak var insetGuides: TMBarLayoutInsetGuides!
    public var layoutGuide: UILayoutGuide {
        return insetGuides!.content
    }
    
    /// Constraint that is active when constraining width to a `.fit` contentMode.
    private var widthConstraint: NSLayoutConstraint?
    
    /**
     The content mode in which to display the content in the layout.
     
     Options:
     - `.intrinsic`: The layout and contents will be intrinsically sized, taking up as much space as required.
     - `.fit`: The layout and it's contents will be restricted to fitting within the bounds of the bar.
     
     By default this is set to `.intrinsic`
    **/
    public var contentMode: ContentMode = .intrinsic {
        didSet {
            guard oldValue != contentMode else {
                return
            }
            update(for: contentMode)
        }
    }
    /// Inset to apply to the outside of the layout.
    open var contentInset: UIEdgeInsets {
        set {
            insetGuides.insets = newValue
            parent.contentInset = newValue
        } get {
            return parent.contentInset
        }
    }
    /// Transition style for updating layout parameters, such as scroll offset.
    public var transitionStyle: TMTransitionStyle {
        set {
            parent.transitionStyle = newValue
        } get {
            return parent.transitionStyle
        }
    }
    
    // MARK: Init
    
    public required init() {}
    
    // MARK: Lifecycle
    
    internal func layout(parent: TMBarLayoutParent,
                         insetGuides: TMBarLayoutInsetGuides) {
        self.parent = parent
        self.insetGuides = insetGuides

        layout(in: view)
    }
    
    /// Layout the `BarLayout`.
    ///
    /// - Parameter view: The view to use as the root of the layout.
    open func layout(in view: UIView) {
    }
    
    /// Insert new bar buttons into the layout from a specified index.
    ///
    /// - Parameters:
    ///   - buttons: The buttons to insert.
    ///   - index: The index to start inserting the buttons at.
    open func insert(buttons: [TMBarButton], at index: Int) {
    }

    /// Remove existing bar buttons from the layout.
    ///
    /// - Parameter buttons: The buttons to remove.
    open func remove(buttons: [TMBarButton]) {
    }

    /// Calculate the `focusRect` for the current position and capacity.
    ///
    /// This rect defines the area of the layout that should currently be highlighted for the selected bar button.
    ///
    /// - Parameters:
    ///   - position: Current position to display.
    ///   - capacity: Capacity of the bar (items).
    /// - Returns: Calculated focus rect.
    open func focusArea(for position: CGFloat, capacity: Int) -> CGRect {
        return .zero
    }
}

private extension TMBarLayout {
    
    /// Update any constraints that are needed to satisfy a new ContentMode.
    ///
    /// - Parameter contentMode: New ContentMode to display.
    func update(for contentMode: ContentMode) {
        switch contentMode {
        case .fit:
            self.widthConstraint = view.widthAnchor.constraint(equalTo: insetGuides.content.widthAnchor)
            widthConstraint?.isActive = true
            
        default:
            widthConstraint?.isActive = false
        }
    }
}
