//
//  PagingStatusDisplay.swift
//  Tabman
//
//  Created by Merrick Sapsford on 07/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation
import Pageboy

internal protocol PagingStatusDisplay: class {
 
    func updateDisplay(for pagePosition: CGFloat,
                       capacity: Int,
                       direction: PageboyViewController.NavigationDirection)
}
