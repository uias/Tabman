//
//  TabmanBarTests.swift
//  Tabman
//
//  Created by Merrick Sapsford on 27/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import XCTest
@testable import Tabman
import Pageboy

class TabmanBarTests: XCTestCase {
    
    var testBar: TabmanTestBar!
    
    //
    // MARK: Environment
    //
    
    override func setUp() {
        super.setUp()
        
        self.testBar = TabmanTestBar()
    }
    
    //
    // MARK: Lifecycle Tests
    //
    
    /// Test whether items are initialized from dataSource correctly.
    func testLifecycleDataSourceLoading() {
        XCTAssert(self.testBar.items?.count == self.testBar.numberOfTabs,
                  "TabmanBar is not loading data source items correctly.")
    }
    
    /// Test whether constructTabBar is called for a valid tab bar.
    func testLifecycleBarConstruction() {
        XCTAssert(self.testBar.hasConstructed == true,
                  "TabmanBar does not call constructTabBar when it is required.")
    }
    
    //
    // MARK: Reloading Tests
    //
    
    /// Test whether data source is reloaded when reloadData is called.
    func testReloadDataSourceLoading() {
        let initialTabCount = self.testBar.items?.count
        
        let revisedTabCount = 3
        self.testBar.numberOfTabs = revisedTabCount
        self.testBar.reloadData()
        
        XCTAssert(self.testBar.items?.count == revisedTabCount && initialTabCount != revisedTabCount,
                  "TabmanBar does not update data source correctly when calling reloadData")
    }
    
    /// Test reloading a data source with a nil items array. 
    /// Items should be nil and the bar should not be constructed.
    func testReloadInvalidDataSourceLoading() {
        self.testBar.numberOfTabs = 0
        self.testBar.reloadData()
        
        XCTAssert(self.testBar.items == nil && self.testBar.hasConstructed == false,
                  "TabmanBar does not handle a nil items array correctly.")
    }
    
    //
    // MARK: Updating tests
    //
    
    /// Test that bar correctly updates when setting a custom appearance
    func testUpdateCustomAppearance() {
        
        let customAppearance = TabmanBar.Appearance({ (appearance) in
            appearance.indicator.color = .green
        })
        
        self.testBar.appearance = customAppearance
        
        XCTAssert(self.testBar.latestAppearanceConfig === customAppearance,
                  "TabmanBar does not respond correctly to setting a custom .appearance property")
    }
    
    /// Test that the bar correctly updates when calling updatePosition
    func testUpdatePosition() {
        let newPosition: CGFloat = 1.50
        let direction: PageboyViewController.NavigationDirection = .forward
        
        self.testBar.updatePosition(newPosition, direction: direction)
        
        XCTAssert(self.testBar.latestPosition == newPosition &&
                  self.testBar.latestDirection == direction &&
                  self.testBar.currentPosition == newPosition,
                  "TabmanBar does not update correctly for position updates.")
    }
}
