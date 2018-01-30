//
//  TabmanFixedButtonBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 24/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

/// A bar with fixed buttons and line indicator.
///
/// Akin to Instagram notification screen etc.
internal class TabmanFixedButtonBar: TabmanStaticButtonBar {

    // MARK: TabmanBar Lifecycle
    
    public override func construct(in contentView: UIView,
                                   for items: [TabmanBar.Item]) {
        super.construct(in: contentView, for: items)
        
        self.addAndLayoutBarButtons(toView: self.contentView, items: items) { (button, _) in
            self.buttons.append(button)
            
            button.addTarget(self, action: #selector(tabButtonPressed(_:)), for: .touchUpInside)
        }
    }
}
