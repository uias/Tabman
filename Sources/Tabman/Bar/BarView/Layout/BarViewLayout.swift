//
//  BarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

open class BarViewLayout: LayoutPerformer, BarFocusProvider {
    
    // MARK: Types
    
    public enum ContentMode {
        case fill
        case fit
    }
    
    // MARK: Properties
    
    let container = BarViewLayoutContainer()
    let contentInsetGuides: BarViewContentInsetGuides
    
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
    
    public required init(contentInsetGuides: BarViewContentInsetGuides) {
        self.contentInsetGuides = contentInsetGuides
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
