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

// MARK: - Child view controller insetting.
internal extension TabmanViewController {
    
    /// Automatically inset any table/collection views in a child view controller for the TabmanBar.
    ///
    /// - Parameter childViewController: The child view controller.
    func insetChildViewControllerIfNeeded(_ childViewController: UIViewController?) {
        
        guard let childViewController = childViewController else { return }
        guard self.automaticallyAdjustsChildScrollViewInsets else { return }
        
        // get all scroll views in view controller root subviews for insetting.
        var scrollViews = [UIScrollView?]()
        if let tableViewController = childViewController as? UITableViewController { // UITableViewController
            scrollViews.append(tableViewController.tableView)
        } else if let collectionViewController = childViewController as? UICollectionViewController { // UICollectionViewController
            scrollViews.append(collectionViewController.collectionView)
        } else if let subviews = childViewController.view?.subviews { // standard subview filtering
            scrollViews.append(contentsOf: subviews.map({ $0 as? UIScrollView }))
        }
        
        // if a scroll view is found in child VC subviews inset by the required content inset.
        for scrollView in scrollViews {
            guard let scrollView = scrollView else { continue }
            guard !scrollView.isBeingInteracted else { continue }
            
            if #available(iOS 11.0, *) {
                scrollView.contentInsetAdjustmentBehavior = .never
            }
            
            var requiredContentInset = self.bar.requiredInsets.all
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
            
            // ensure scroll view is either at top or full height before doing automatic insetting
            var isValidLayout = true
            checkIsNotEmbeddedViewController(childViewController, {
                if requiredContentInset.top > 0.0 {
                    isValidLayout = scrollView.frame.minY == 0.0
                }
                if requiredContentInset.bottom > 0.0 {
                    guard let scrollViewSuperview = scrollView.superview else {
                        return
                    }
                    isValidLayout = (scrollViewSuperview.bounds.maxY - scrollView.frame.maxY) == 0.0
                }
            })
            
            guard isValidLayout else {
                continue
            }
            
            // dont update if we dont need to
            if scrollView.contentInset != requiredContentInset {
            
                scrollView.contentInset = requiredContentInset
                scrollView.scrollIndicatorInsets = requiredContentInset
                
                var contentOffset = scrollView.contentOffset
                contentOffset.y = -requiredContentInset.top
                scrollView.contentOffset = contentOffset
            }
        }
    }
    
    /// Check whether a view controller is not an 'embedded' view controller type (i.e. UITableViewController)
    ///
    /// - Parameters:
    ///   - viewController: The view controller.
    ///   - success: Execution if view controller is not embedded type.
    private func checkIsNotEmbeddedViewController(_ viewController: UIViewController, _ success: () -> Void) {
        if !(viewController is UITableViewController) && !(viewController is UICollectionViewController) {
            success()
        }
    }
}

// MARK: - UIViewController extension for handling insetting.
public extension UIViewController {
    
    /// Indicates to the TabmanViewController that a child scroll view inset 
    /// needs to be updated.
    ///
    /// This should be called if the contentInset of a UITableView or UICollectionView is changed
    /// after viewDidLoad.
    public func setNeedsScrollViewInsetUpdate() {
        guard let tabmanViewController = self.parent?.parent as? TabmanViewController else { return }
        tabmanViewController.insetChildViewControllerIfNeeded(self)
    }
}
