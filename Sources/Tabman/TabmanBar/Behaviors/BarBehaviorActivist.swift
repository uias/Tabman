//
//  BarBehaviorActivist.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import Foundation

internal class BarBehaviorActivist {
 
    // MARK: Types
    
    enum Activator {
        case onBarChange
        case onPositionChange
    }
    
    // MARK: Properties
    
    let behavior: TabmanBar.Behavior
    let activator: Activator
    let otherBehaviors: [TabmanBar.Behavior]
    private(set) weak var bar: TabmanBar?
    
    // MARK: Init
    
    required init(for behavior: TabmanBar.Behavior,
                  activator: Activator,
                  bar: TabmanBar?,
                  otherBehaviors: [TabmanBar.Behavior]) {
        self.behavior = behavior
        self.activator = activator
        self.bar = bar
        self.otherBehaviors = otherBehaviors
    }
    
    // MARK: Lifecycle
    
    func update() {
        fatalError("Implement update() in subclass")
    }
}
