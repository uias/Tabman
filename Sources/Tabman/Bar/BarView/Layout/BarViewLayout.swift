//
//  BarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

open class BarViewLayout: LayoutPerformer, BarFocusProvider {
    
    // MARK: Properties
    
    let container = BarViewLayoutContainer()
    
    /// Bar View that is presenting the layout.
    public private(set) weak var presentingView: UIView!
    /// Bounds of the bar view that is presenting the layout.
    public var presentingBounds: CGRect {
        presentingView.layoutIfNeeded()
        return presentingView.bounds
    }
    
    // MARK: Init
    
    public required init(for presentingView: UIView) {
        self.presentingView = presentingView     
    }
    
    // MARK: LayoutPerformer
    
    public private(set) var hasPerformedLayout = false

    internal func performLayout() {
        performLayout(in: container)
    }
    
    open func performLayout(in view: UIView) {
        guard !hasPerformedLayout else {
            fatalError("performLayout() can only be called once.")
        }
        hasPerformedLayout = true
    }
    
    // MARK: Lifecycle
    
    func populate(with barButtons: [BarButton]) {
        fatalError("Implement in subclass")
    }
    
    func clear() {
        fatalError("Implement in subclass")
    }
    
    // MARK: BarFocusProvider
    
    func barFocusRect(for position: CGFloat, capacity: Int) -> CGRect {
        fatalError("Implement in subclass")
    }
}

// MARK: - Customization
public extension BarViewLayout {
    
    public var isUserInteractionEnabled: Bool {
        set {
            container.isUserInteractionEnabled = newValue
        } get {
            return container.isUserInteractionEnabled
        }
    }
}
