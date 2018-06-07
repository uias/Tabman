//
//  BarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

open class BarLayout: LayoutPerformer, BarFocusProvider {
    
    // MARK: Properties
    
    let container = BarLayoutContainer()
    private weak var barView: UIView?
    
    /// Bounds of the bar view that is presenting the layout.
    public var barBounds: CGRect {
        barView?.layoutIfNeeded()
        return barView?.bounds ?? .zero
    }
    
    // MARK: Init
    
    public required init(for referenceView: UIView) {
        self.barView = referenceView
        container.backgroundColor = .red
        
        performLayout(in: container)
    }
    
    // MARK: LayoutPerformer
    
    public private(set) var hasPerformedLayout = false

    open func performLayout(in view: UIView) {
        guard !hasPerformedLayout else {
            fatalError("performLayout() can only be called once.")
        }
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
public extension BarLayout {
    
    public var isUserInteractionEnabled: Bool {
        set {
            container.isUserInteractionEnabled = newValue
        } get {
            return container.isUserInteractionEnabled
        }
    }
}
