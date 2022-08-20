//
//  TMBarButtonController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 05/07/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import Foundation

/// A controller which is responsible for a collection of bar buttons.
internal class TMBarButtonController {
    
    // MARK: Properties
    
    let barButtons: [WeakContainer<TMBarButton>]
    
    // MARK: Init
    
    init(for barButtons: [TMBarButton]) {
        self.barButtons = barButtons.map({ WeakContainer<TMBarButton>(for: $0) })
    }
}
