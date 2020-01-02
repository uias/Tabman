//
//  AutoInsetter.swift
//  AutoInset
//
//  Created by Merrick Sapsford on 16/01/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// Engine that provides Auto Insetting to UIViewControllers.
internal final class AutoInsetter {
    
    // MARK: Properties
    
    private var currentContentInsets = [UIScrollView: UIEdgeInsets]()
    private var currentContentOffsets = [UIScrollView: CGPoint]()
    
    private let insetStore: InsetStore = DefaultInsetStore()
    
    /// Whether auto-insetting is enabled.
    @available(*, deprecated, message: "Use enable(for:)")
    public var isEnabled: Bool {
        set {
            if newValue {
                _enable(for: nil)
            }
        } get {
            return _isEnabled
        }
    }
    private var _isEnabled: Bool = false
    
    // MARK: Init
    
    init() {}
    
    // MARK: State
    
    /// Enable Auto Insetting for a view controller.
    ///
    /// - Parameter viewController: View controller that will provide insetting.
    func enable(for viewController: UIViewController?) {
        _enable(for: viewController)
    }
    
    private func _enable(for viewController: UIViewController?) {
        _isEnabled = true
        viewController?.automaticallyAdjustsScrollViewInsets = false
    }
    
    // MARK: Insetting
    
    /// Inset a view controller by a set of required insets.
    ///
    /// - Parameters:
    ///   - viewController: view controller to inset.
    ///   - requiredInsetSpec: The required inset specification.
    func inset(_ viewController: UIViewController?,
               requiredInsetSpec: AutoInsetSpec) {
        guard let viewController = viewController, _isEnabled else {
            return
        }
        
        if #available(iOS 11, *) {
            if requiredInsetSpec.additionalRequiredInsets != viewController.additionalSafeAreaInsets {
                viewController.additionalSafeAreaInsets = requiredInsetSpec.additionalRequiredInsets
            }
        } else { // manual insetting on older versions.
            guard viewController.shouldEvaluateEmbeddedScrollViews() else {
                return
            }
            viewController.forEachEmbeddedScrollView { (scrollView) in
                let calculator = self.makeInsetCalculator(for: scrollView, viewController: viewController)
                let executor = InsetExecutor(view: scrollView, calculator: calculator, spec: requiredInsetSpec)
    
                executor.execute(store: insetStore)
    
                viewController.view.setNeedsLayout()
            }
        }
    }
}

extension AutoInsetter {
    
    @available(iOS, deprecated: 11)
    private func makeInsetCalculator(for scrollView: UIScrollView, viewController: UIViewController) -> InsetCalculator {
        
        if let tableView = scrollView as? UITableView {
            return TableViewInsetCalculator(view: tableView, viewController: viewController)
        } else if let collectionView = scrollView as? UICollectionView {
            return CollectionViewInsetCalculator(view: collectionView, viewController: viewController)
        }
        return ScrollViewInsetCalculator(view: scrollView, viewController: viewController)
    }
}

// MARK: - Utilities
private extension AutoInsetter {
    
    /// Check whether a view controller is an 'embedded' view controller type (i.e. UITableViewController)
    ///
    /// - Parameters:
    ///   - viewController: The view controller.
    ///   - success: Execution if view controller is not embedded type.
    func isEmbeddedViewController(_ viewController: UIViewController) -> Bool {
        if (viewController is UITableViewController) || (viewController is UICollectionViewController) {
            return true
        }
        return false
    }
}
