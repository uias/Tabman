//
//  TabmanIndicatorTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Pageboy

/// Transition protocol for indicators.
internal class TabmanIndicatorTransition: TabmanTransition {
    
    var tabmanBar: TabmanBar?
    
    required init() {
    }
    
    func transition(withPosition position: CGFloat,
                    direction: PageboyViewController.NavigationDirection,
                    minimumIndex: Int, maximumIndex: Int) {
        
    }
    
    func updateForCurrentPosition() {
        
    }
}
