//
//  BarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

open class BarLayout {
    
    let container = BarLayoutContainer()
    
    // MARK: Init
    
    public required init() {
        container.backgroundColor = .red
        
        layout(in: container)
    }
    
    // MARK: Layout
    
    open func layout(in container: UIView) {
        
    }
}
