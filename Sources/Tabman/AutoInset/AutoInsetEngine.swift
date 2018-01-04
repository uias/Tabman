//
//  AutoInsetEngine.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import Foundation

class AutoInsetEngine {
    
    // MARK: Properties
    
    private var viewControllerInsets: [Int: UIEdgeInsets] = [:]
    
    /// Whether auto-insetting is enabled.
    var isEnabled: Bool = true
    
    // MARK: Insetting
    
    func inset(_ childViewController: UIViewController?,
               requiredInsets: TabmanBar.Insets) {
        guard let childViewController = childViewController else {
            return
        }
        guard isEnabled else { // reset safe areas / contentInset
            reset(childViewController, from: requiredInsets)
            return
        }
        
        if #available(iOS 11, *) {
            childViewController.additionalSafeAreaInsets = requiredInsets.barInsets
        }
        
        childViewController.forEachEmbeddedScrollView { (scrollView) in
            
            if #available(iOS 11.0, *) {
                scrollView.contentInsetAdjustmentBehavior = .never
            }
            
            let requiredContentInset = calculateActualRequiredContentInset(for: scrollView,
                                                                           from: requiredInsets)
            
            // ensure scroll view is either at top or full height before doing automatic insetting
            ensureLayoutIsValid(for: childViewController,
                                with: scrollView,
                                requiredContentInset: requiredContentInset,
                                success:
                {
                    // dont update if we dont need to
                    if scrollView.contentInset != requiredContentInset {
                        
                        let isTopInsetChanged = requiredContentInset.top != scrollView.contentInset.top
                        
                        scrollView.contentInset = requiredContentInset
                        scrollView.scrollIndicatorInsets = requiredContentInset
                        
                        // only update contentOffset if the top contentInset has updated.
                        if isTopInsetChanged {
                            var contentOffset = scrollView.contentOffset
                            contentOffset.y = -requiredContentInset.top
                            scrollView.contentOffset = contentOffset
                        }
                    }
            })
        }
    }
    
    private func reset(_ childViewController: UIViewController,
                       from requiredInsets: TabmanBar.Insets) {
        
        if #available(iOS 11, *) {
            childViewController.additionalSafeAreaInsets = .zero
        }
        
        childViewController.forEachEmbeddedScrollView { (scrollView) in
            if #available(iOS 11, *) {
                scrollView.contentInsetAdjustmentBehavior = .automatic
            }
            scrollView.contentInset = .zero
            scrollView.contentOffset = .zero
            scrollView.scrollIndicatorInsets = .zero
        }
    }

    // MARK: Utility
    
    /// Check whether a view controller is not an 'embedded' view controller type (i.e. UITableViewController)
    ///
    /// - Parameters:
    ///   - viewController: The view controller.
    ///   - success: Execution if view controller is not embedded type.
    private func isNotEmbeddedViewController(_ viewController: UIViewController) -> Bool {
        if !(viewController is UITableViewController) && !(viewController is UICollectionViewController) {
            return true
        }
        return false
    }
    
    /// Calculate the actual inset values to use including any custom contentInset values.
    ///
    /// - Parameters:
    ///   - scrollView: Scroll view.
    ///   - requiredInsets: Required TabmanBar insets.
    /// - Returns: Actual contentInset values to use.
    private func calculateActualRequiredContentInset(for scrollView: UIScrollView,
                                                     from requiredInsets: TabmanBar.Insets) -> UIEdgeInsets {
        var requiredContentInset = requiredInsets.all
        let currentContentInset = self.viewControllerInsets[scrollView.hash] ?? .zero
        
        self.viewControllerInsets[scrollView.hash] = requiredContentInset
        
        // take account of custom top / bottom insets
        let topInset = scrollView.contentInset.top - currentContentInset.top
        if topInset != 0.0 {
            requiredContentInset.top += topInset
        }
        let bottomInset = scrollView.contentInset.bottom - currentContentInset.bottom
        if bottomInset != 0.0 {
            requiredContentInset.bottom += bottomInset
        }
        
        requiredContentInset.left = currentContentInset.left
        requiredContentInset.right = currentContentInset.right
        
        return requiredContentInset
    }
    
    private func ensureLayoutIsValid(for childViewController: UIViewController,
                                     with scrollView: UIScrollView,
                                     requiredContentInset: UIEdgeInsets,
                                     success: () -> Void) {
        if isNotEmbeddedViewController(childViewController) {
            
            var isValidLayout = true
            if requiredContentInset.top > 0.0 {
                isValidLayout = scrollView.frame.minY == 0.0
            }
            if requiredContentInset.bottom > 0.0 {
                // TODO - Figure out a way to check whether bottom of scroll view goes underneath bar.
            }
            
            if isValidLayout {
                success()
            }
            
        } else {
            success()
        }
    }
}

private extension UIViewController {
    
    var embeddedScrollViews: [UIScrollView?] {
        if let tableViewController = self as? UITableViewController { // UITableViewController
            return [tableViewController.tableView]
        } else if let collectionViewController = self as? UICollectionViewController { // UICollectionViewController
            return [collectionViewController.collectionView]
        } else { // standard subview filtering
            return scrollViews(in: self.view)
        }
    }
    
    func scrollViews(in view: UIView) -> [UIScrollView] {
        var scrollViews = [UIScrollView]()
        if let scrollView = view as? UIScrollView {
            scrollViews.append(scrollView)
            return scrollViews
        }
        
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollViews.append(scrollView)
                return scrollViews
            }
            
            scrollViews.append(contentsOf: self.scrollViews(in: subview))
        }
        return scrollViews
    }
    
    func forEachEmbeddedScrollView(_ action: (UIScrollView) -> Void) {
        for scrollView in self.embeddedScrollViews {
            guard let scrollView = scrollView else { continue }
            guard !scrollView.isBeingInteracted else { continue }
            
            action(scrollView)
        }
    }
}
