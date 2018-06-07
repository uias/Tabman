//
//  BarFocusProvider.swift
//  Tabman
//
//  Created by Merrick Sapsford on 07/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal protocol BarFocusProvider: class {
    
    func barFocusRect(for position: CGFloat, capacity: Int) -> CGRect
}
