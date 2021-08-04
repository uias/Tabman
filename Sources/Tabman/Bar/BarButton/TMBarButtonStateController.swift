//
//  TMBarButtonStateController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 03/07/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

/// A bar button controller that is responsible for handling the control state of buttons.
internal final class TMBarButtonStateController: TMBarButtonController {
    
    // MARK: Properties
    
    private weak var selectedButton: TMBarButton? {
        didSet {
            if oldValue !== selectedButton {
                oldValue?.selectionState = .unselected
            }
            selectedButton?.selectionState = .selected
        }
    }
    
    // MARK: Init
    
    override init(for barButtons: [TMBarButton]) {
        super.init(for: barButtons)
        barButtons.forEach({ $0.selectionState = .unselected })
    }
    
    // MARK: Update
    
    func update(for position: CGFloat, direction: TMBarUpdateDirection) {
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
        
        let progressComplement = 1.0 - directionalProgress
        if progressComplement < 0.001 { // e - 0.001
            self.selectedButton = targetButton
        }
        
        oldTargetButton?.selectionState = .from(rawValue: progressComplement)
    }
}
