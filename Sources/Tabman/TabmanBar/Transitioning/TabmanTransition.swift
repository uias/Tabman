//
//  TabmanTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation
import Pageboy

internal protocol TabmanTransitionLifecycle {
    
    /// The TabmanBar to use for the transition.
    var tabmanBar: TabmanBar? { get set }
    
    /// Update the transition for a new position.
    ///
    /// - Parameters:
    ///   - position: The new position.
    ///   - direction: The direction of the scroll.
    ///   - indexRange: The range of valid indexes.
    ///   - bounds: The bounds for the TabmanBar.
    func transition(withPosition position: CGFloat,
                    direction: PageboyViewController.NavigationDirection,
                    indexRange: Range<Int>,
                    bounds: CGRect)
    
    /// Reload the transition for the current bar position.
    func updateForCurrentPosition()
}

internal class TabmanTransition: Any, TabmanTransitionLifecycle {
    
    var tabmanBar: TabmanBar?
    
    required init() {
    }
    
    func transition(withPosition position: CGFloat,
                    direction: PageboyViewController.NavigationDirection,
                    indexRange: Range<Int>,
                    bounds: CGRect) {
        
    }
    
    func updateForCurrentPosition() {
        
    }
}

extension TabmanTransition: Hashable, Equatable {
    
    static func == (lhs: TabmanTransition, rhs: TabmanTransition) -> Bool {
        return String(describing: lhs) == String(describing: rhs)
    }
    
    var hashValue: Int {
        return String(describing: type(of: self)).hashValue
    }
}
