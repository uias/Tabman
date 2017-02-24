//
//  TabmanAutoLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

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
