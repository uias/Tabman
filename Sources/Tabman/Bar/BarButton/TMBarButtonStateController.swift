//
//  TMBarButtonStateController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 03/07/2018.
//  Copyright © 2020 UI At Six. All rights reserved.
//

import UIKit

/// A bar button controller that is responsible for handling the control state of buttons.
internal final class TMBarButtonStateController: TMBarButtonController {
    
    // MARK: Properties
    
    private var selectedButtons: [TMBarButton]? {
        didSet {
            if oldValue != selectedButtons {
                oldValue?.forEach({ $0.selectionState = .unselected })
            }
            selectedButtons?.forEach({ $0.selectionState = .selected })
        }
    }
    
    // MARK: Init
    
    override init(for barButtons: [TMBarButton]) {
        super.init(for: barButtons)
        barButtons.forEach({ $0.selectionState = .unselected })
    }
    
    // MARK: Update
    
    func update(for position: CGFloat, direction: TMBarUpdateDirection) {
        let barButtons = self.barButtons.compactMap({ $0.object })
        
        let capacity = barButtons.count
        let range = BarMath.localIndexRange(for: position, minimum: 0, maximum: capacity - 1)
        guard barButtons.count > range.upperBound else {
            return
        }
        
        let lowerButtons = barButtons.filter({ $0.itemIndex == range.lowerBound })
        let upperButtons = barButtons.filter({ $0.itemIndex == range.upperBound })
        
        let targetButtons = direction != .reverse ? upperButtons : lowerButtons
        let oldTargetButtons = direction != .reverse ? lowerButtons : upperButtons
        
        let progress = BarMath.localProgress(for: position)
        let directionalProgress = direction != .reverse ? progress : 1.0 - progress
        
        guard targetButtons.first !== oldTargetButtons.first else {
            self.selectedButtons = targetButtons
            return
        }
        
        targetButtons.forEach({ $0.selectionState = .from(rawValue: directionalProgress) })
        oldTargetButtons.forEach({ $0.selectionState = .from(rawValue: 1.0 - directionalProgress) })
    }
}
