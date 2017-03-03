//
//  TabmanIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 03/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

public protocol TabmanIndicatorLifecycle {
    
    /// Construct the indicator
    func constructIndicator()
}

open class TabmanIndicator: UIView, TabmanIndicatorLifecycle {
    
    //
    // MARK: Types
    //
    
    public enum Style {
        case none
        case line
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
