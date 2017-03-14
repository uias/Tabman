//
//  TabmanTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Pageboy

internal protocol TabmanTransition {
    
    func transition(withPosition position: CGFloat,
                    direction: PageboyViewController.NavigationDirection,
                    minimumIndex: Int,
                    maximumIndex: Int)
}
