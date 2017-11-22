//
//  TabmanViewController+Insetting.swift
//  Tabman
//
//  Created by Merrick Sapsford on 19/04/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

// MARK: - Required Bar inset calculation.
internal extension TabmanViewController {
    
    /// Reload the required bar insets for the current bar.
    func reloadRequiredBarInsets() {
        
        var layoutInsets: UIEdgeInsets = .zero
        if #available(iOS 11, *) {
            layoutInsets = view.safeAreaInsets
        } else {
            layoutInsets.top = topLayoutGuide.length
            layoutInsets.bottom = bottomLayoutGuide.length
        }
        
        self.bar.requiredInsets = TabmanBar.Insets(safeAreaInsets: layoutInsets,
                                                   bar: self.calculateRequiredBarInsets())
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
