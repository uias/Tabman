//
//  MyCustomLayout.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 02/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Tabman

class MyCustomBarViewLayout: BarViewLayout {
    
    override func performLayout(in view: UIView) {
        super.performLayout(in: view)
    }
    
    override func populate(with barButtons: [BarButton]) {
        
    }
    
    override func clear() {
        
    }
    
    override func barFocusRect(for position: CGFloat, capacity: Int) -> CGRect {
        return .zero
    }
}
