//
//  TMBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2020 UI At Six. All rights reserved.
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
    
    /// Area of the layout.
    ///
    /// - `.main`: Main interactable area where buttons exist.
    /// - `.leadingAuxiliary`: Area leading `.main` area which is used for non-interactable buttons to support infinite bar behavior.
    /// - `.trailingAuxiliary`: Area trailing `.main` area which is used for non-interactable buttons to support infinite bar behavior.
    public enum LayoutArea {
        case main
        case leadingAuxiliary
        case trailingAuxiliary
    }
    
    // MARK: Properties
    
    /// Container view which contains actual contents
    public let view = TMBarLayoutView()
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
    
    public var leadingAccessoryView: TMBarAccessoryView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let leadingAccessoryView = leadingAccessoryView {
                addAccessoryView(leadingAccessoryView, to: view.container(.leadingAccessory))
            }
        }
    }
    
    public var trailingAccessoryView: TMBarAccessoryView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let trailingAccessoryView = trailingAccessoryView {
                addAccessoryView(trailingAccessoryView, to: view.container(.trailingAccessory))
            }
        }
    }
    
    // MARK: Init
    
    public required init() {}
    
    // MARK: Lifecycle
    
    internal func layout(parent: TMBarLayoutParent,
                         insetGuides: TMBarLayoutInsetGuides) {
        self.parent = parent
        self.insetGuides = insetGuides
        
        layout(in: view.container(.main), area: .main)
        layout(in: view.container(.leadingAuxiliary), area: .leadingAuxiliary)
        layout(in: view.container(.trailingAuxiliary), area: .trailingAuxiliary)
    }
    
    /// Layout the contents of the `BarLayout` for an area.
    /// - Parameters:
    ///   - view: View to layout.
    ///   - area: Area for the current view.
    open func layout(in view: UIView, area: LayoutArea) {
    }
    
    /// Insert new buttons into the layout at an index for a specific area.
    /// - Parameters:
    ///   - buttons: Buttons to insert.
    ///   - index: Index to start inserting buttons at.
    ///   - area: Area to insert the buttons into.
    open func insert(buttons: [TMBarButton], at index: Int, in area: LayoutArea) {
    }
    
    /// Remove existing buttons from the layout for a specific area.
    /// - Parameters:
    ///   - buttons: Buttons to remove.
    ///   - area: Area to remove the buttons from.
    open func remove(buttons: [TMBarButton], from area: LayoutArea) {
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


// MARK: - Accessory Views
extension TMBarLayout {
    
    private func addAccessoryView(_ view: TMBarAccessoryView, to container: UIView) {
        container.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            view.topAnchor.constraint(equalTo: container.topAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
