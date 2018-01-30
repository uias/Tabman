//
//  TabmanItemColorCrossfadeTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

/// TabmanItemColorCrossfadeTransition
///
/// Transition that cross-fades colors on the selected and unselected items to signify the active item.
class TabmanItemColorCrossfadeTransition: TabmanItemTransition {
    
    override func transition(withPosition position: CGFloat,
                             direction: PageboyViewController.NavigationDirection,
                             indexRange: Range<Int>,
                             bounds: CGRect) {
        guard let bar = tabmanBar as? TabmanButtonBar else {
            return
        }
        
        let (lowerIndex, upperIndex) = TabmanPositionalUtil.lowerAndUpperIndex(forPosition: position,
                                                                               minimum: indexRange.lowerBound,
                                                                               maximum: indexRange.upperBound)
        
        guard bar.buttons.count > max(upperIndex, lowerIndex) else {
            return
        }
        let lowerButton = bar.buttons[lowerIndex]
        let upperButton = bar.buttons[upperIndex]
        
        let targetButton = direction == .forward ? upperButton : lowerButton
        let oldTargetButton = direction == .forward ? lowerButton : upperButton
        
        var integral: Float = 0.0
        let transitionProgress = CGFloat(modff(Float(position), &integral))
        
        let relativeProgress = direction == .forward ? transitionProgress : 1.0 - transitionProgress
        
        self.updateButtons(inBar: bar,
                           withTargetButton: targetButton,
                           oldTargetButton: oldTargetButton,
                           progress: relativeProgress)
    }
    
    private func updateButtons(inBar bar: TabmanButtonBar,
                               withTargetButton targetButton: UIButton,
                               oldTargetButton: UIButton,
                               progress: CGFloat) {
        guard targetButton !== oldTargetButton else {
            bar.focussedButton = targetButton
            return
        }
        
        let targetColor = UIColor.interpolate(betweenColor: bar.color,
                                              and: bar.selectedColor,
                                              percent: progress)
        let oldTargetColor = UIColor.interpolate(betweenColor: bar.color,
                                                 and: bar.selectedColor,
                                                 percent: 1.0 - progress)
        
        targetButton.tintColor = targetColor
        targetButton.setTitleColor(targetColor, for: .normal)
        oldTargetButton.tintColor = oldTargetColor
        oldTargetButton.setTitleColor(oldTargetColor, for: .normal)
    }
}
