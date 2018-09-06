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
    
    public enum OverscrollBehavior {
        case bounce
        case compress
        case none
    }
    
    // MARK: Properties
    
    open var displayStyle: DisplayStyle {
        fatalError("Return displayStyle in subclass")
    }
    
    /**
     Behavior the indicator should exhibit when scrolling over the bounds of the bar.
     
     Options:
     - `.bounce`: Bounce the indicator beyond the bounds of the bar.
     - `.compress`: Compress the indicators width as overscroll occurs.
     - `.none`: Don't do anything when overscrolling.
     
     Defaults to `.bounce`.
     **/
    public var overscrollBehavior: OverscrollBehavior = .bounce
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
