//
//  TabmanTestBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 27/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
@testable import Tabman
import Pageboy

class TabmanTestBar: TabmanBar {
    
    //
    // MARK: Test flags
    //
    
    var numberOfTabs: Int = 5
    
    var hasConstructed: Bool = false
    var latestPosition: CGFloat?
    var latestDirection: PageboyViewController.NavigationDirection?
    var latestAppearanceConfig: TabmanBar.Appearance?
    
    //
    // MARK: Init
    //
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initTestBar()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initTestBar()
    }
    
    private func initTestBar() {
        self.dataSource = self
    }
    
    //
    // MARK: Lifecycle
    //
    
    override func reloadData() {
        
        // reset flags
        self.hasConstructed = false
        
        super.reloadData()
    }
    
    override func construct(in contentView: UIView, for items: [TabmanBarItem]) {
        self.hasConstructed = true
    }
    
    override func add(indicator: TabmanIndicator, to contentView: UIView) {
    }
    
    override func update(forPosition position: CGFloat,
                         direction: PageboyViewController.NavigationDirection,
                         indexRange: Range<Int>,
                         bounds: CGRect) {
        super.update(forPosition: position,
                     direction: direction,
                     indexRange: indexRange,
                     bounds: bounds)
        
        self.latestPosition = position
        self.latestDirection = direction
    }
    
    override func update(forAppearance appearance: Appearance,
                         defaultAppearance: Appearance) {
        super.update(forAppearance: appearance,
                     defaultAppearance: defaultAppearance)
        
        self.latestAppearanceConfig = appearance
    }
}

extension TabmanTestBar: TabmanBarDataSource {
    
    func items(for bar: TabmanBar) -> [TabmanBarItem]? {
        guard numberOfTabs > 0 else {
            return nil
        }
        
        var items = [TabmanBarItem]()
        for index in 0 ..< numberOfTabs {
            items.append(TabmanBarItem(title: "Tab\(index)"))
        }
        return items
    }
}
