//
//  TabmanScrollingBarIndicatorTransition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

/// Transition for updating a scrolling bar.
/// Handles keeping indicator centred and scrolling for item visibility.
internal class TabmanScrollingBarIndicatorTransition: TabmanIndicatorTransition {

    override func transition(withPosition position: CGFloat,
                             direction: PageboyViewController.NavigationDirection,
                             indexRange: Range<Int>,
                             bounds: CGRect) {
        guard let scrollingButtonBar = self.tabmanBar as? TabmanScrollingButtonBar else {
            return
        }
        
        let (lowerIndex, upperIndex) = TabmanPositionalUtil.lowerAndUpperIndex(forPosition: position,
                                                                               minimum: indexRange.lowerBound,
                                                                               maximum: indexRange.upperBound)
        let lowerButton = scrollingButtonBar.buttons[lowerIndex]
        let upperButton = scrollingButtonBar.buttons[upperIndex]

        var integral: Float = 0.0
        let transitionProgress = CGFloat(modff(Float(position), &integral))
        
        self.updateIndicator(forTransitionProgress: transitionProgress,
                             in: scrollingButtonBar,
                             lowerButton: lowerButton,
                             upperButton: upperButton)
        self.scrollIndicatorPositionToVisible(in: scrollingButtonBar)
    }
    
    override func updateForCurrentPosition() {
        guard let scrollingButtonBar = self.tabmanBar as? TabmanScrollingButtonBar else {
            return
        }

        self.scrollIndicatorPositionToVisible(in: scrollingButtonBar)
    }
    
    // MARK: Updating
    
    private func updateIndicator(forTransitionProgress progress: CGFloat,
                                 in bar: TabmanScrollingButtonBar,
                                 lowerButton: UIButton,
                                 upperButton: UIButton) {
        
        let layoutIsRtoL = bar.layoutIsRightToLeft
        if bar.indicatorIsProgressive {
            
            let indicatorStartFrame = lowerButton.frame.origin.x + lowerButton.frame.size.width
            let indicatorEndFrame = upperButton.frame.origin.x + upperButton.frame.size.width
            let endFrameDiff = indicatorEndFrame - indicatorStartFrame
            
            bar.indicatorWidth?.constant = indicatorStartFrame + (endFrameDiff * progress)
            
            guard bar.indicatorBounces || bar.indicatorCompresses else {
                return
            }
            if lowerButton === upperButton {
                let indicatorWidth = bar.indicatorWidth?.constant ?? 0.0
                bar.indicatorWidth?.constant = indicatorWidth + (indicatorWidth * progress)
            }
            
        } else {
            
            let widthDiff = (upperButton.frame.size.width - lowerButton.frame.size.width) * progress
            let interpolatedWidth = lowerButton.frame.size.width + widthDiff
            bar.indicatorWidth?.constant = interpolatedWidth
            
            let xDiff = (upperButton.frame.origin.x - lowerButton.frame.origin.x) * progress
            let interpolatedXOrigin = lowerButton.frame.origin.x + xDiff
            bar.indicatorLeftMargin?.constant = interpolatedXOrigin
            
            let isOutOfBounds = lowerButton === upperButton
            
            // compress indicator at boundaries if required
            if bar.indicatorCompresses && isOutOfBounds {
                let indicatorWidth = bar.indicatorWidth?.constant ?? 0.0
                let indicatorDiff = (indicatorWidth * fabs(progress))
                
                bar.indicatorWidth?.constant = indicatorWidth - indicatorDiff
                if (progress > 0.0 && !layoutIsRtoL) || (progress < 0.0 && layoutIsRtoL) {
                    let indicatorLeftMargin = bar.indicatorLeftMargin?.constant ?? 0.0
                    bar.indicatorLeftMargin?.constant = indicatorLeftMargin + indicatorDiff
                }
            }
            
            // bounce indicator at boundaries if required
            if bar.indicatorBounces && isOutOfBounds {
                let indicatorWidth = bar.indicatorWidth?.constant ?? 0.0
                let leftMargin = (bar.indicatorLeftMargin?.constant ?? 0.0)
                let bounceOffset = (indicatorWidth * progress)
                bar.indicatorLeftMargin?.constant = leftMargin + (layoutIsRtoL ? -bounceOffset : bounceOffset)
            }
        }
    }
    
    private func scrollIndicatorPositionToVisible(in bar: TabmanScrollingButtonBar) {
        var offset: CGFloat = 0.0
        let contentInset = bar.scrollView.contentInset
        let maxOffset = (bar.scrollView.contentSize.width + contentInset.right) - bar.bounds.size.width
        let minOffset = -contentInset.left
        
        if bar.indicatorIsProgressive {
            
            let index = Int(ceil(bar.currentPosition))
            guard bar.buttons.count > index else {
                return
            }
            
            let buttonFrame = bar.buttons[index].frame
            offset = ((bar.indicatorWidth?.constant ?? 0.0) - (bar.bounds.size.width / 2.0)) - (buttonFrame.size.width / 2.0)
            
        } else {
            
            let indicatorXOffset = bar.indicatorLeftMargin?.constant ?? 0.0
            let indicatorWidthOffset = (bar.bounds.size.width - (bar.indicatorWidth?.constant ?? 0)) / 2.0
            
            guard indicatorWidthOffset > 0.0 else {
                return
            }
            
            offset = indicatorXOffset - indicatorWidthOffset
        }
        
        offset = max(minOffset, min(maxOffset, offset))
        bar.scrollView.contentOffset = CGPoint(x: offset, y: 0.0)
    }
}
