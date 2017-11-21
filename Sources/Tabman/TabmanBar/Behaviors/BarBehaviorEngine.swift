//
//  BarBehaviorEngine.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import Foundation

internal class BarBehaviorEngine {
    
    // MARK: Properties
    
    weak var bar: TabmanBar?
    
    var activeBehaviors: [TabmanBar.Behavior] = [] {
        didSet {
            updateActiveBehaviors(to: activeBehaviors)
        }
    }
    
    // MARK: Init
    
    init(for bar: TabmanBar) {
        self.bar = bar
    }
    
    // MARK: Behaviors
    
    private func updateActiveBehaviors(to behaviors: [TabmanBar.Behavior]) {
        dump(behaviors)
    }
}
