//
//  TabmanItemMaskTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

/// TabmanItemMaskTransition
///
/// Transition that adjusts the frame of the TabmanBar indicatorMaskView to be over the active item frame.
class TabmanItemMaskTransition: TabmanItemTransition {
    
    override func transition(withPosition position: CGFloat,
                             direction: PageboyViewController.NavigationDirection,
                             indexRange: Range<Int>,
                             bounds: CGRect) {
        guard let bar = tabmanBar else {
            return
        }
        
        bar.contentView.layoutIfNeeded()
        bar.indicatorMaskView.frame = bar.indicator?.frame ?? .zero
    }
}
