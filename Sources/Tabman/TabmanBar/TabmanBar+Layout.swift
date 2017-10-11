//
//  TabmanBar+Layout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

// MARK: - Bar location management
internal extension TabmanBar {
    
    @discardableResult func barAutoPinToTop(topLayoutGuide: UILayoutSupport) -> [NSLayoutConstraint]? {
        guard self.superview != nil else {
            return nil
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        let margins = self.layoutMargins
        let views: [String: Any] = ["view" : self, "topLayoutGuide" : topLayoutGuide]
        let xConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|",
                                                          options: NSLayoutFormatOptions(),
                                                          metrics: nil, views: views)
        let yConstraints = NSLayoutConstraint.constraints(withVisualFormat: String(format: "V:[topLayoutGuide]-%i-[view]", -margins.top),
                                                          options: NSLayoutFormatOptions(),
                                                          metrics: nil, views: views)
        constraints.append(contentsOf: xConstraints)
        constraints.append(contentsOf: yConstraints)
        
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult func barAutoPinToBotton(bottomLayoutGuide: UILayoutSupport) -> [NSLayoutConstraint]? {
        guard self.superview != nil else {
            return nil
        }
        self.translatesAutoresizingMaskIntoConstraints = false

        var constraints = [NSLayoutConstraint]()
        
        let margins = self.layoutMargins
        let views: [String: Any] = ["view" : self, "bottomLayoutGuide" : bottomLayoutGuide]
        let xConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|",
                                                          options: NSLayoutFormatOptions(),
                                                          metrics: nil, views: views)
        let yConstraints = NSLayoutConstraint.constraints(withVisualFormat: String(format: "V:[view]-%i-[bottomLayoutGuide]", -margins.bottom),
                                                          options: NSLayoutFormatOptions(),
                                                          metrics: nil, views: views)
        constraints.append(contentsOf: xConstraints)
        constraints.append(contentsOf: yConstraints)
        
        self.superview?.addConstraints(constraints)
        return constraints
    }
}

// MARK: - Background View layout
internal extension TabmanBar {
    
    /// Extend the background view for system areas if applicable.
    ///
    /// - Parameters:
    ///   - location: The current location of the bar.
    ///   - viewController: The view controller containing the bar.
    ///   - appearance: The appearance configuration of the bar.
    func extendBackgroundForSystemAreasIfNeeded(for location: TabmanBar.Location,
                                                in viewController: UIViewController,
                                                appearance: TabmanBar.Appearance) {
        let safeAreaInsets = generateSafeAreaInsetsIfNeeded(from: viewController)
        
        extendBackgroundForStatusBarIfNeeded(location: location,
                                             safeAreaInsets: safeAreaInsets,
                                             appearance: appearance)
        
        if #available(iOS 11, *) {
            extendBackgroundForBottomSafeAreaIfNeeded(location: location,
                                                      viewController: viewController,
                                                      safeAreaInsets: safeAreaInsets,
                                                      appearance: appearance)
        }
    }
    
    /// Generate a set of insets for safe areas. (Uses layout guides on <iOS 11)
    ///
    /// - Parameter viewController: The view controller to generate insets for.
    /// - Returns: Safe area insets.
    private func generateSafeAreaInsetsIfNeeded(from viewController: UIViewController) -> UIEdgeInsets {
        if #available(iOS 11, *) {
            return viewController.view.safeAreaInsets
        }
        
        var safeAreaInsets = UIEdgeInsets.zero
        safeAreaInsets.top = viewController.topLayoutGuide.length
        safeAreaInsets.bottom = viewController.bottomLayoutGuide.length
        return safeAreaInsets
    }
    
    /// Extends the bar background view underneath status bar if applicable.
    ///
    /// - Parameters:
    ///   - location: The location of the bar.
    ///   - safeAreaInsets: The current insets of the safe area.
    ///   - appearance: The appearance configuration of the bar.
    private func extendBackgroundForStatusBarIfNeeded(location: TabmanBar.Location,
                                                      safeAreaInsets: UIEdgeInsets,
                                              appearance: TabmanBar.Appearance) {
        guard let topPinConstraint = self.backgroundView.constraints.first else { return }
        guard location == .top, appearance.layout.extendBackgroundEdgeInsets ?? false else {
            topPinConstraint.constant = 0.0
            return
        }
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        if safeAreaInsets.top == statusBarHeight {
            topPinConstraint.constant = -statusBarHeight
        }
    }
    
    @available (iOS 11, *)
    /// Extends the bar background view onto bottom safe area if applicable (for iPhone X).
    ///
    /// - Parameters:
    ///   - location: The location of the bar.
    ///   - viewController: The view controller that the bar is contained in.
    ///   - safeAreaInsets: The current insets of the safe area.
    ///   - appearance: The appearance configuration of the bar.
    func extendBackgroundForBottomSafeAreaIfNeeded(location: TabmanBar.Location,
                                                   viewController: UIViewController,
                                                   safeAreaInsets: UIEdgeInsets,
                                                   appearance: TabmanBar.Appearance) {
        let bottomPinConstraint = self.backgroundView.constraints[2]
        let extendBackgroundEdgeInsets = appearance.layout.extendBackgroundEdgeInsets ?? false
        
        // ensure location is bottom, extending is enabled
        // and view controller is not in a tab bar controller.
        guard location == .bottom &&
            extendBackgroundEdgeInsets &&
            viewController.tabBarController == nil else {
            bottomPinConstraint.constant = 0.0
            return
        }
        
        let bottomSafeAreaInset = safeAreaInsets.bottom
        bottomPinConstraint.constant = bottomSafeAreaInset
    }
}
