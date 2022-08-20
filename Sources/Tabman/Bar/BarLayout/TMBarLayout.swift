//
//  TMBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

/// `TMBarLayout` dictates the way that BarButtons are displayed within a bar, handling layout and population.
///
/// Attention: You should not directly use `BarLayout`, but instead inherit from it or use an available subclass such as `TMHorizontalBarLayout`.
open class TMBarLayout: TMBarViewFocusProvider, TMTransitionStyleable {
    
    // MARK: Types
    
    /// How to display the contents of the layout.
    ///
    /// - `.intrinsic`: The layout and contents will be intrinsically sized, taking up as much space as required.
    /// - `.fit`: The layout and it's contents will be restricted to fitting within the bounds of the bar.
    public enum ContentMode {
        case intrinsic
        case fit
    }
    
    /// How to align the layout in the parent.
    ///
    /// - `.leading`: The layout will be aligned from the leading edge of the parent.
    /// - `.center`: The layout will be aligned from the center of the parent.
    /// - `.centerDistributed`: The layout will be aligned so that its entire contents is centered in the parent if possible.
    /// - `.trailing`: The layout will be aligned from the trailing edge of the parent.
    public enum Alignment {
        case leading
        case center
        case centerDistributed
        case trailing
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
        get {
            return parent.contentInset
        }
        set {
            insetGuides.insets = newValue
            parent.contentInset = newValue
        }
    }
    /// Transition style for updating layout parameters, such as scroll offset.
    public var transitionStyle: TMTransitionStyle {
        get {
            return parent.transitionStyle
        }
        set {
            parent.transitionStyle = newValue
        }
    }
    /**
     How to align the layout in the bar.
     
     Options:
     - `.leading`: The layout will be aligned from the leading edge of the parent.
     - `.center`: The layout will be aligned from the center of the parent.
     - `.trailing`: The layout will be aligned from the trailing edge of the parent.
     */
    public var alignment: Alignment {
        get {
            return parent.alignment
        }
        set {
            parent.alignment = newValue
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
    
    /// Inform that the layout requires a reload of its contents.
    ///
    /// - Note: This will only be applied if the layout has previously
    /// had content provided.
    ///
    open func setNeedsReload() {
        parent.layout(needsReload: self)
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
