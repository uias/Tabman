//
//  TabmanBarTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Pageboy

internal protocol TabmanBarTransitionLifecycle {
    
    func transition(withPosition position: CGFloat,
                    direction: PageboyViewController.NavigationDirection,
                    minimumIndex: Int,
                    maximumIndex: Int)
}

internal class TabmanBarTransition: Any, TabmanBarTransitionLifecycle {
    
    func transition(withPosition position: CGFloat,
                    direction: PageboyViewController.NavigationDirection,
                    minimumIndex: Int,
                    maximumIndex: Int) {
        fatalError("transition(withPosition: direction: minimumIndex: maximumIndex:) should be implemented in subclass")
    }
    
}
