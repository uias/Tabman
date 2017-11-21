//
//  TabmanBar+Behaviors.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import Foundation

public extension TabmanBar {
    
    public enum Behavior {
        
        public enum AutoHiding {
            case none
            case withOneItem
        }
        
        case autoHiding(AutoHiding)
    }
}

internal extension TabmanBar.Behavior {
    
    var activistType: BarBehaviorActivist.Type? {
        switch self {
            
        case .autoHiding:
            return AutoHideBarBehaviorActivist.self
        }
    }
}
