//
//  TabmanViewController+Insetting.swift
//  Tabman
//
//  Created by Merrick Sapsford on 19/04/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

internal extension TabmanViewController {
    
    /// Reload the required bar insets for the current bar.
    func reloadRequiredBarInsets() {
        let oldInset = self.bar.requiredContentInset
        self.bar.requiredContentInset = self.calculateRequiredBarInsets()
        
        // reset insetted controllers list if inset changes
        if oldInset != self.bar.requiredContentInset {
            self.insettedViewControllers.removeAll()
        }
    }
    
    /// Calculate the required insets for the current bar.
    ///
    /// - Returns: The required bar insets
    private func calculateRequiredBarInsets() -> UIEdgeInsets {
        guard self.embeddingView == nil && self.attachedTabmanBar == nil else {
            return .zero
        }
        
        let frame = self.activeTabmanBar?.frame ?? .zero
        var insets = UIEdgeInsets.zero
        
        var location = self.bar.location
        if location == .preferred {
            location = self.bar.style.preferredLocation
        }
        
        switch location {
        case .bottom:
            insets.bottom = frame.size.height
            
        default:
            insets.top = frame.size.height
        }
        return insets
    }
}

// MARK: - Child view controller layout
internal extension TabmanViewController {
    
    func insetChildViewControllerIfNeeded(_ childViewController: UIViewController?) {
        guard let childViewController = childViewController else { return }
        
        let isInsetted = self.insettedViewControllers.contains(childViewController)
        
        // if a scroll view is found in child VC subviews inset by the required content inset.
        for subview in childViewController.view?.subviews ?? [] {
            if let scrollView = subview as? UIScrollView {
                
                var requiredContentInset = self.bar.requiredContentInset
                let currentContentInset = scrollView.contentInset
                
                requiredContentInset.top += self.topLayoutGuide.length
                
                requiredContentInset.top += isInsetted ? currentContentInset.top - requiredContentInset.top : currentContentInset.top
                requiredContentInset.bottom += isInsetted ? currentContentInset.bottom - requiredContentInset.bottom : currentContentInset.bottom
                requiredContentInset.left = currentContentInset.left
                requiredContentInset.right = currentContentInset.right
                
                scrollView.contentInset = requiredContentInset
                
                var contentOffset = scrollView.contentOffset
                contentOffset.y = -requiredContentInset.top
                scrollView.contentOffset = contentOffset
            }
        }
        
        self.insettedViewControllers.append(childViewController)
    }
}
