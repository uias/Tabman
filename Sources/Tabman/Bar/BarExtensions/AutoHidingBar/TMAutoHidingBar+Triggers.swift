//
//  TMAutoHidingBar+Triggers.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/12/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal class TMAutoHidingTriggerHandler {
    
    private weak var bar: TMAutoHidingBar!
    
    var viewController: UIViewController? {
        return bar.delegate as? UIViewController
    }
    
    // MARK: Init
    
    init(for bar: TMAutoHidingBar) {
        self.bar = bar
    }
}

internal class TMAutoHidingTimeTriggerHandler: TMAutoHidingTriggerHandler {
    
    init(for bar: TMAutoHidingBar, duration: TimeInterval) {
        super.init(for: bar)
    }
}
