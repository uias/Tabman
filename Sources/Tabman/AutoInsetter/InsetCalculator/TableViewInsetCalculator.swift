//
//  TableViewInsetCalculator.swift
//  AutoInsetter
//
//  Created by Merrick Sapsford on 16/03/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

internal class TableViewInsetCalculator: ViewInsetCalculator<UITableView> {
    
    override func calculateContentInset(from spec: AutoInsetSpec, store: InsetStore) -> ContentInsetCalculation? {
        let previous = store.contentInset(for: view) ?? .zero
        let allRequiredInsets = spec.allRequiredInsets
        
        // If UITableViewController then just return all insets (exc. horizontal)
        guard isScrollViewController == false else {
            let contentInset = UIEdgeInsets(top: allRequiredInsets.top,
                                            left: 0.0,
                                            bottom: allRequiredInsets.bottom,
                                            right: 0.0)
            guard view.contentInset != contentInset else {
                return nil
            }
            return ContentInsetCalculation(new: contentInset,
                                           previous: previous,
                                           currentActual: view.contentInset)
        }
        
        let relativeFrame = viewController.view.convert(view.frame, from: view.superview)
        
        // top
        let topInset = max(allRequiredInsets.top - relativeFrame.minY, 0.0)
        
        // bottom
        let bottomInsetMinY = viewController.view.bounds.height - allRequiredInsets.bottom
        let bottomInset = abs(min(bottomInsetMinY - relativeFrame.maxY, 0.0))
        
        let contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: bottomInset, right: 0.0)
        
        guard contentInset != view.contentInset else {
            return nil
        }
        store.store(contentInset: contentInset, for: view)
        
        let customContentInset = applyCustomContentInset(to: contentInset, from: previous)
        return ContentInsetCalculation(new: customContentInset,
                                       previous: previous,
                                       currentActual: view.contentInset)
    }
    
    override func calculateContentOffset(from insetCalculation: ContentInsetCalculation, store: InsetStore) -> ContentOffsetCalculation? {
        guard insetCalculation.currentActual.top != insetCalculation.new.top else {
            return nil
        }
        
        // Calculate the delta between the new content inset top and actual current content inset top
        // This provides the amount that we potentially have to update the content offset by.
        let topInsetDelta = insetCalculation.new.top - insetCalculation.currentActual.top
        
        // Get the previously stored content offset
        let previous = store.contentOffset(for: view)
        var contentOffset = previous ?? .zero

        // Calculate the delta between the views current content offset and previously stored offset.
        var contentOffsetYDelta = view.contentOffset.y - contentOffset.y
        if contentOffsetYDelta > 0 { // if the scroll offset is positive (scrolled down)
            contentOffsetYDelta += contentOffset.y + insetCalculation.new.top // add the current offset and new top inset.
        }
        contentOffset.y -= topInsetDelta // adjust for the top inset delta
        
        // store the new offset (which has no user applied values yet)
        store.store(contentOffset: contentOffset, for: view)
        
        // Apply the user applied content offset if required
        if contentOffsetYDelta > 0 && floor(contentOffsetYDelta) != topInsetDelta {
            contentOffset.y += contentOffsetYDelta
        }
        
        return ContentOffsetCalculation(new: contentOffset,
                                        previous: previous,
                                        currentActual: view.contentOffset)
    }
    
    override func calculateScrollIndicatorInsets(from spec: AutoInsetSpec) -> UIEdgeInsets? {
        let allRequiredInsets = spec.allRequiredInsets
        
        // UITableViewController
        guard isScrollViewController == false else {
            let scrollIndicatorInsets = allRequiredInsets
            guard view.scrollIndicatorInsets != scrollIndicatorInsets else {
                return nil
            }
            return scrollIndicatorInsets
        }
        
        let relativeFrame = viewController.view.convert(view.frame, from: view.superview)
        
        // top
        let topInset = max(allRequiredInsets.top - relativeFrame.minY, 0.0)
        
        // left
        let leftInset = max(allRequiredInsets.left - relativeFrame.minX, 0.0)
        
        // right
        let rightInsetMinX = viewController.view.bounds.width - allRequiredInsets.right
        let rightInset = abs(min(rightInsetMinX - relativeFrame.maxX, 0.0))
        
        // bottom
        let bottomInsetMinY = viewController.view.bounds.height - allRequiredInsets.bottom
        let bottomInset = abs(min(bottomInsetMinY - relativeFrame.maxY, 0.0))
        
        let scrollIndicatorInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        guard view.scrollIndicatorInsets != scrollIndicatorInsets else {
            return nil
        }
        return scrollIndicatorInsets
    }
}
