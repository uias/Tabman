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
        case wrap
        case fit
    }
    
    // MARK: Properties
    
    let container = BarViewLayoutContainer()
    let layoutReferences: BarViewLayoutReferences
    
    public var contentMode: ContentMode = .wrap {
        didSet {
            guard oldValue != contentMode else {
                return
            }
            update(for: contentMode)
        }
    }
    
    // MARK: Init
    
    public required init(layoutReferences: BarViewLayoutReferences) {
        self.layoutReferences = layoutReferences
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
            container.snp.makeConstraints { (make) in
                make.width.equalTo(layoutReferences.rootView.snp.width)
            }
        default:
            break
        }
    }
}
