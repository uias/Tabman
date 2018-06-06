//
//  BarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

open class BarLayout: LayoutPerformer {
    
    let container = BarLayoutContainer()
    
    
    // MARK: Init
    
    public required init() {
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
}
