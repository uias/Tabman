//
//  TabmanBlockTabBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 09/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout
import Pageboy

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
        return .custom(type: TabmanBlockIndicator.self)
    }
    
    override func usePreferredIndicatorStyle() -> Bool {
        return false
    }
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
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
        indicator.autoPinEdge(toSuperviewEdge: .top)
        self.indicatorLeftMargin = indicator.autoPinEdge(toSuperviewEdge: .left)
        self.indicatorWidth = indicator.autoSetDimension(.width, toSize: 0.0)
    }
    
    override public func update(forPosition position: CGFloat,
                                direction: PageboyViewController.NavigationDirection,
                                minimumIndex: Int,
                                maximumIndex: Int) {
        super.update(forPosition: position,
                     direction: direction,
                     minimumIndex: minimumIndex,
                     maximumIndex: maximumIndex)
        
        let screenWidth = self.bounds.size.width
        let itemCount = CGFloat(self.items?.count ?? 0)
        let itemWidth = screenWidth / itemCount
        
        if self.indicatorIsProgressive {
            
            let relativePosition = (position + 1.0) / CGFloat((self.items?.count ?? 1))
            let indicatorWidth = max(0.0, min(screenWidth, screenWidth * relativePosition))
            
            var bouncyIndicatorWidth = indicatorWidth
            if !self.indicatorBounces {
                bouncyIndicatorWidth = max(itemWidth, min(screenWidth, bouncyIndicatorWidth))
            }
            self.indicatorWidth?.constant = bouncyIndicatorWidth
            
        } else {
            
            let relativePosition = position / CGFloat((self.items?.count ?? 1))
            let leftMargin = relativePosition * screenWidth
            
            var bouncyIndicatorPosition = leftMargin
            if !self.indicatorBounces {
                bouncyIndicatorPosition = max(0.0, min(screenWidth - itemWidth, bouncyIndicatorPosition))
            }
            self.indicatorLeftMargin?.constant = bouncyIndicatorPosition
            self.indicatorWidth?.constant = itemWidth
        }
    }

}
