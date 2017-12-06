//
//  AutoHideBarBehaviorActivist.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import Foundation

class AutoHideBarBehaviorActivist: BarBehaviorActivist {
    
    // MARK: Properties
    
    private var autoHideBehavior: TabmanBar.Behavior.AutoHiding? {
        if case .autoHide(let behavior) = self.behavior {
            return behavior
        }
        return nil
    }
    
    // MARK: Lifecycle
    
    override func update() {
        guard let behavior = self.autoHideBehavior else {
            return
        }
        
        switch behavior {
            
        case .always:
            bar?.isHidden = true
            
        case .withOneItem:
            bar?.isHidden = bar?.items?.count == 1
            
        default:
            bar?.isHidden = false
        }
    }
}
