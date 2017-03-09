//
//  TabmanBlockTabBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 09/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout

class TabmanBlockTabBar: TabmanBar {
    
    //
    // MARK: Properties
    //
    
    override var itemCountLimit: Int? {
        return 5
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 50.0)
    }
    
    //
    // MARK: Lifecycle
    //
    
    override func defaultIndicatorStyle() -> TabmanIndicator.Style {
        return .block
    }
    
    override func usePreferredIndicatorStyle() -> Bool {
        return false
    }
    
    override func constructTabBar(items: [TabmanBarItem]) {
        super.constructTabBar(items: items)
        
        var previousButton: UIButton?
        for (index, item) in items.enumerated() {
            
            let button = UIButton(forAutoLayout: ())
            self.contentView.addSubview(button)
            
            if let title = item.title {
                button.setTitle(title, for: .normal)
            } else if let image = item.image {
                button.setImage(image, for: .normal)
            }
            
            // layout
            button.autoPinEdge(toSuperviewEdge: .top)
            button.autoPinEdge(toSuperviewEdge: .bottom)
            if previousButton == nil {
                button.autoPinEdge(toSuperviewEdge: .left)
            } else {
                button.autoPinEdge(.left, to: .right, of: previousButton!)
                button.autoMatch(.width, to: .width, of: previousButton!)
            }
            if index == items.count - 1 {
                button.autoPinEdge(toSuperviewEdge: .right)
            }
            
            previousButton = button
        }
    }
    
    override func addIndicatorToBar(indicator: TabmanIndicator) {
        super.addIndicatorToBar(indicator: indicator)
        
        self.contentView.addSubview(indicator)
        indicator.autoPinEdge(toSuperviewEdge: .bottom)
        self.indicatorLeftMargin = indicator.autoPinEdge(toSuperviewEdge: .left)
        self.indicatorWidth = indicator.autoSetDimension(.width, toSize: 0.0)

    }
}
