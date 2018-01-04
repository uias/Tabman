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
    
    private weak var bar: TabmanBar?
    
    var activeBehaviors: [TabmanBar.Behavior]? {
        didSet {
            loadActivists(for: activeBehaviors ?? [])
        }
    }
    private var activists = [BarBehaviorActivist.Activator: [BarBehaviorActivist]]()
    
    // MARK: Init
    
    init(for bar: TabmanBar) {
        self.bar = bar
    }
    
    // MARK: Behaviors
    
    private func loadActivists(for behaviors: [TabmanBar.Behavior]) {
        activists.removeAll()
        
        for (index, behavior) in behaviors.enumerated() {
            
            var otherBehaviors = behaviors
            otherBehaviors.remove(at: index)
            
            guard let activist = behavior.activistType?.init(for: behavior,
                                                             activator: behavior.activator,
                                                             bar: self.bar,
                                                             otherBehaviors: otherBehaviors) else {
                continue
            }
            var activists = self.activists[behavior.activator] ?? []
            activists.append(activist)
            self.activists[behavior.activator] = activists
            
            activist.update()
        }
    }
    
    func update(activation: BarBehaviorActivist.Activator) {
        activists[activation]?.forEach { (activist) in
            activist.update()
        }
    }
}
