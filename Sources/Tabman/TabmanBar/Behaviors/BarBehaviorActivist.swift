//
//  BarBehaviorActivist.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import Foundation

internal class BarBehaviorActivist {
 
    // MARK: Properties
    
    let behavior: TabmanBar.Behavior
    private(set) weak var bar: TabmanBar?
    
    // MARK: Init
    
    required init(for behavior: TabmanBar.Behavior, bar: TabmanBar?) {
        self.behavior = behavior
        self.bar = bar
    }
    
    // MARK: Lifecycle
    
    func update() {
        
    }
}
