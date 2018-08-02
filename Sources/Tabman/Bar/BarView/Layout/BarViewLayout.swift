//
//  BarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/**
 `BarViewLayout` dictates the way that BarButtons are displayed within a bar, handling layout and population.
 
 Attention: You should not directly use `BarViewLayout`, but instead inherit from it or use an available Tabman subclass such as `ButtonBarViewLayout`.
 **/
open class BarViewLayout: LayoutPerformer, BarViewFocusProvider {
    
    // MARK: Types
    
    public enum ContentMode {
        case fill
        case fit
    }
    
    // MARK: Properties
    
    let container = BarViewLayoutContainer()
    private weak var contentInsetGuides: BarViewContentInsetGuides!
    private weak var contentView: UIScrollView!
    
    /**
     The display mode in which to display the content in the layout.
     
     Options:
     - `.fill`: The layout and contents will be intrinsically sized, taking up as much space as required.
     - `.fit`: The layout and it's contents will be restricted to fitting within the bounds of the bar.
     
     By default this is set to `.fill`
    **/
    public var contentMode: ContentMode = .fill {
        didSet {
            guard oldValue != contentMode else {
                return
            }
            update(for: contentMode)
        }
    }
    
    private var widthConstraint: NSLayoutConstraint?
    
    // MARK: Init
    
    public required init(contentView: UIScrollView) {
        self.contentView = contentView
    }
    
    // MARK: LayoutPerformer
    
    public private(set) var hasPerformedLayout = false

    internal func performLayout(contentInsetGuides: BarViewContentInsetGuides) {
        self.contentInsetGuides = contentInsetGuides
        performLayout(in: container)
    }
    
    open func performLayout(in view: UIView) {
        guard !hasPerformedLayout else {
            fatalError("performLayout() can only be called once.")
        }
        hasPerformedLayout = true
    }
    
    // MARK: Lifecycle
    
    /** Populate the layout with the bar buttons to display in the bar.
     
     - Parameter barButtons: Bar buttons to display.
     - Parameter index: The index that the bar buttons should be populated at (in cases of insertion etc).
     **/
    open func populate(with barButtons: [BarButton], at index: Int? = nil) {
        fatalError("Implement in subclass")
    }
    
    /// Remove all populated content from the layout.
    open func clear() {
        fatalError("Implement in subclass")
    }
    
    // MARK: BarViewFocusProvider
    
    /**
     Calculate the `focusRect` for the current position and capacity.
     
     This rect defines the area of the layout that should currently be highlighted for the selected bar button.

     - Parameter position: Current position to display.
     - Parameter capacity: Capacity of the bar (items).
     
     - Returns: Calculated focus rect.
     **/
    open func barFocusRect(for position: CGFloat, capacity: Int) -> CGRect {
        fatalError("Implement in subclass")
    }
}

// MARK: - Customization
public extension BarViewLayout {
    
    /// Inset to apply to the outside of the layout.
    public var contentInset: UIEdgeInsets {
        set {
            contentInsetGuides.contentInset = newValue
            contentView.contentInset = newValue
        } get {
            return contentView.contentInset
        }
    }
    /// Whether the layout should be allowed to be scrolled by the user.
    public var isScrollEnabled: Bool {
        set {
            contentView.isScrollEnabled = newValue
        } get {
            return contentView.isScrollEnabled
        }
    }
    /// Whether the user can interact with the layout directly.
    public var isUserInteractionEnabled: Bool {
        set {
            container.isUserInteractionEnabled = newValue
        } get {
            return container.isUserInteractionEnabled
        }
    }
}

private extension BarViewLayout {
    
    func update(for contentMode: ContentMode) {
        switch contentMode {
        case .fit:
            self.widthConstraint = container.widthAnchor.constraint(equalTo: contentInsetGuides.content.widthAnchor)
            widthConstraint?.isActive = true
            
        default:
            widthConstraint?.isActive = false
        }
    }
}
