//
//  BarButtonStateController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 03/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation
import Pageboy

internal final class BarButtonStateController: BarButtonController {
    
    // MARK: Properties
    
    private weak var selectedButton: BarButton? {
        didSet {
            if oldValue !== selectedButton {
                oldValue?.selectionState = .unselected
            }
            selectedButton?.selectionState = .selected
        }
    }
    
    // MARK: Update
    
    func update(for position: CGFloat, direction: NavigationDirection) {
        let capacity = barButtons.count
        let range = BarMath.localIndexRange(for: position, minimum: 0, maximum: capacity - 1)
        guard barButtons.count > range.upperBound else {
            return
        }
        
        let lowerButton = barButtons[range.lowerBound].object
        let upperButton = barButtons[range.upperBound].object
        
        let targetButton = direction != .reverse ? upperButton : lowerButton
        let oldTargetButton = direction != .reverse ? lowerButton : upperButton
        
        let progress = BarMath.localProgress(for: position)
        let directionalProgress = direction != .reverse ? progress : 1.0 - progress
        
        guard targetButton !== oldTargetButton else {
            self.selectedButton = targetButton
            return
        }
        
        targetButton?.selectionState = .from(rawValue: directionalProgress)
        oldTargetButton?.selectionState = .from(rawValue: 1.0 - directionalProgress)
    }
}
