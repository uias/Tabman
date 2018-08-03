//
//  BarButtonController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 05/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

internal class BarButtonController {
    
    // MARK: Properties
    
    let barButtons: [WeakContainer<BarButton>]
    
    // MARK: Init
    
    init(for barButtons: [BarButton]) {
        self.barButtons = barButtons.map({ WeakContainer<BarButton>(for: $0) })
    }
}
