//
//  CustomTabmanBar.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 03/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class CustomTabmanBar: TabmanBar {

    // MARK: Lifecycle
    
    override func defaultIndicatorStyle() -> TabmanIndicator.Style {
        // declare indicator style here
        return .clear
    }
    
    override func usePreferredIndicatorStyle() -> Bool {
        // Whether to use preferredIndicatorStyle
        return true
    }
    
    // MARK: TabmanBar Lifecycle
    
    public override func construct(in contentView: UIView,
                                   for items: [TabmanBar.Item]) {
        
        // create your bar here
        let label = UILabel()
        label.text = "This is a custom TabmanBar"
        label.textAlignment = .center
        label.textColor = .white
        self.contentView.addSubview(label)
    
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
    public override func add(indicator: TabmanIndicator,
                             to contentView: UIView) {
        // add indicator to bar here
    }
    
    override func update(forPosition position: CGFloat,
                         direction: PageboyViewController.NavigationDirection,
                         indexRange: Range<Int>,
                         bounds: CGRect) {
        super.update(forPosition: position,
                     direction: direction,
                     indexRange: indexRange,
                     bounds: bounds)
        // update your bar for a positional update here
    }
    
    override func update(forAppearance appearance: Appearance,
                         defaultAppearance: Appearance) {
        super.update(forAppearance: appearance,
                     defaultAppearance: defaultAppearance)
        
        // update the bar appearance here
    }
}
