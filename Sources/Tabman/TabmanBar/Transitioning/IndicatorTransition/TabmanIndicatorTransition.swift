//
//  TabmanIndicatorTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Pageboy

internal protocol TabmanIndicatorTransition {
    
    var tabmanBar: TabmanBar? { get set }
    
    func transition(withPosition position: CGFloat,
                    direction: PageboyViewController.NavigationDirection,
                    minimumIndex: Int,
                    maximumIndex: Int)
}
