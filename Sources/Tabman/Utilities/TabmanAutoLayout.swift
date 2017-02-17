//
//  TabmanAutoLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

internal extension TabmanBar {
    
    @discardableResult func tabBarAutoPinToTop(topLayoutGuide: UILayoutSupport) -> [NSLayoutConstraint]? {
        guard self.superview != nil else {
            return nil
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.removeAllConstraints()
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
    
    @discardableResult func tabBarAutoPinToBotton(bottomLayoutGuide: UILayoutSupport) -> [NSLayoutConstraint]? {
        guard self.superview != nil else {
            return nil
        }
        self.translatesAutoresizingMaskIntoConstraints = false

        self.removeAllConstraints()
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

internal extension UIView {
    
    /// Remove all constraints from a view.
    func removeAllConstraints() {
        var superview = self.superview
        while superview != nil {
            for constraint in superview!.constraints {
                if constraint.firstItem === self || constraint.secondItem === self {
                    superview?.removeConstraint(constraint)
                }
            }
            superview = superview?.superview
        }
        
        self.removeConstraints(self.constraints)
    }
}
