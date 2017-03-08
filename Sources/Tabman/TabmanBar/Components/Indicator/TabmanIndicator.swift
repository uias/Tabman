//
//  TabmanIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 03/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

/// The lifecycle for an indicator.
public protocol TabmanIndicatorLifecycle {
    
    /// Construct the indicator
    func constructIndicator()
}

/// Indicator that highlights the currently visible page.
open class TabmanIndicator: UIView, TabmanIndicatorLifecycle {
    
    //
    // MARK: Types
    //
    
    /// The style of indicator to display.
    ///
    /// - none: No indicator.
    /// - line: Horizontal line pinned to bottom of bar.
    /// - dot: Circular centered dot pinned to the bottom of the bar.
    /// - custom: A custom defined indicator.
    public enum Style {
        case none
        case line
        case dot
        case custom(type: TabmanIndicator.Type)
    }
    
    //
    // MARK: Init
    //
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initIndicator()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initIndicator()
    }
    
    private func initIndicator() {
        self.constructIndicator()
    }
    
    //
    // MARK: Lifecycle
    //
    
    open func constructIndicator() {
        // Implement in subclass
    }
}
