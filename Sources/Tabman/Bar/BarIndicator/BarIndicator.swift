//
//  BarIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 07/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

open class BarIndicator: UIView, LayoutPerformer {
    
    // MARK: Types
    
    public enum DisplayStyle {
        case header
        case fill
        case footer
    }
    
    // MARK: Properties
    
    open var displayStyle: DisplayStyle {
        fatalError("Return displayStyle in subclass")
    }
    
    /// Whether the indicator should overscroll and 'bounce' at the end of page ranges.
    public var bounces: Bool = true
    /// Whether the indicator should display progressively, traversing page indexes as progress.
    public var isProgressive: Bool = false
    
    // MARK: Init
    
    public required init() {
        super.init(frame: .zero)
        initialize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        performLayout(in: self)
    }
    
    // MARK: LayoutPerformer
    
    public private(set) var hasPerformedLayout: Bool = false
    public func performLayout(in view: UIView) {
        guard !hasPerformedLayout else {
            return
        }
        hasPerformedLayout = true
    }
}
