//
//  UIViewController+ScrollViewDetection.swift
//  AutoInset
//
//  Created by Merrick Sapsford on 16/01/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal extension UIViewController {
    
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
        
        for subview in view.subviews {
            // if current view is scroll view add it and ignore the subviews
            // - as it can be assumed they will be insetted correctly within the parent scroll view.
            if let scrollView = subview as? UIScrollView {
                scrollViews.append(scrollView)
            } else {
                scrollViews.append(contentsOf: self.scrollViews(in: subview))
            }
        }
        return scrollViews
    }
    
    func forEachEmbeddedScrollView(_ action: (UIScrollView) -> Void) {
        for scrollView in self.embeddedScrollViews {
            guard let scrollView = scrollView, scrollView.window != nil else { continue }
            
            action(scrollView)
        }
    }
    
    func shouldEvaluateEmbeddedScrollViews() -> Bool {
        if self is UIPageViewController { // Ignore UIPageViewController
            return false
        }
        return true
    }
}
