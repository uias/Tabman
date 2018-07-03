//
//  BarButtonStateController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 03/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation
import Pageboy

internal final class BarButtonStateController {
    
    // MARK: Init
    
    init?(for barButtons: [BarButton]?) {
        guard let barButtons = barButtons else {
            return nil
        }
    }
    
    // MARK: Update
    
    func update(for position: CGFloat, direction: NavigationDirection) {
        
        print("Update Position: \(position)")
    }
}
