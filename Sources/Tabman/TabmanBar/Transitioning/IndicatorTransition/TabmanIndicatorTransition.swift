//
//  TabmanIndicatorTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Pageboy

/// Transition protocol for indicators.
internal protocol TabmanIndicatorTransition: TabmanTransition {
    
    var tabmanBar: TabmanBar? { get set }
    
    func updateForCurrentPosition()
}
