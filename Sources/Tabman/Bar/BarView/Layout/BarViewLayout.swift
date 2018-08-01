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
    private let contentInsetGuides: BarViewContentInsetGuides
    private weak var contentView: UIScrollView!
    
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
    
    public required init<LayoutType, ButtonBarType>(in barView: BarView<LayoutType, ButtonBarType>,
                                                    contentView: UIScrollView) {
        self.contentInsetGuides = BarViewContentInsetGuides(for: barView)
        self.contentView = contentView
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
    
    public var contentInset: UIEdgeInsets {
        set {
            contentInsetGuides.contentInset = newValue
            contentView.contentInset = newValue
        } get {
            return contentView.contentInset
        }
    }
    
    public var isScrollEnabled: Bool {
        set {
            contentView.isScrollEnabled = newValue
        } get {
            return contentView.isScrollEnabled
        }
    }
    
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
