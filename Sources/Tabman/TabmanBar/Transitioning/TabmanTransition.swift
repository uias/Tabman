//
//  TabmanTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Pageboy

internal protocol TabmanTransitionLifecycle {
    
    var tabmanBar: TabmanBar? { get set }
    
    func transition(withPosition position: CGFloat,
                    direction: PageboyViewController.NavigationDirection,
                    minimumIndex: Int,
                    maximumIndex: Int)
    
    func updateForCurrentPosition()
}

internal class TabmanTransition: Any, TabmanTransitionLifecycle {
    
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

extension TabmanTransition: Hashable, Equatable {
    
    static func ==(lhs: TabmanTransition, rhs: TabmanTransition) -> Bool {
        return String(describing: lhs) == String(describing: rhs)
    }
    
    var hashValue: Int {
        return String(describing: type(of: self)).hashValue
    }
}
