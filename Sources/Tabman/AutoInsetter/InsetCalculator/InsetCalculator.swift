//
//  InsetCalculator.swift
//  AutoInsetter
//
//  Created by Merrick Sapsford on 16/03/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

internal protocol InsetCalculator: AnyObject {
    
    func calculateContentInset(from spec: AutoInsetSpec, store: InsetStore) -> ContentInsetCalculation?

    func calculateContentOffset(from insetCalculation: ContentInsetCalculation, store: InsetStore) -> ContentOffsetCalculation?
    
    func calculateScrollIndicatorInsets(from spec: AutoInsetSpec) -> UIEdgeInsets?
}

internal class ViewInsetCalculator<InsetView: UIScrollView>: InsetCalculator {
    
    let view: InsetView
    let viewController: UIViewController
    
    init(view: InsetView, viewController: UIViewController) {
        self.view = view
        self.viewController = viewController
        
        viewController.view.layoutIfNeeded()
    }
    
    func calculateContentInset(from spec: AutoInsetSpec, store: InsetStore) -> ContentInsetCalculation? {
        assert(false, "Override in subclass")
        return nil
    }
    
    func calculateContentOffset(from insetCalculation: ContentInsetCalculation, store: InsetStore) -> ContentOffsetCalculation? {
        assert(false, "Override in subclass")
        return nil
    }
    
    func calculateScrollIndicatorInsets(from spec: AutoInsetSpec) -> UIEdgeInsets? {
        assert(false, "Override in subclass")
        return nil
    }
    
    // MARK: Utility
    
    func applyCustomContentInset(to contentInset: UIEdgeInsets, from previous: UIEdgeInsets?) -> UIEdgeInsets {
        let previous = previous ?? .zero
        var contentInset = contentInset
        
        // Take into account any custom insets
        if view.contentInset.top != 0.0 {
            contentInset.top += view.contentInset.top - previous.top
        }
        if view.contentInset.left != 0.0 {
            contentInset.left += view.contentInset.left - previous.left
        }
        if view.contentInset.bottom != 0.0 {
            contentInset.bottom += view.contentInset.bottom - previous.bottom
        }
        if  view.contentInset.right != 0.0 {
            contentInset.right += view.contentInset.right - previous.right
        }
        
        return contentInset
    }
    
    /// Whether the view controller is a 'Scroll View UIViewController' - a.k.a a `UITableViewController` et al.
    var isScrollViewController: Bool {
        return (viewController is UITableViewController) || (viewController is UICollectionViewController)
    }
}
