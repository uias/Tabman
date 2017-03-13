//
//  TabmanViewControllerTests.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import XCTest
@testable import Tabman
import Pageboy

class TabmanViewControllerTests: XCTestCase {

    var tabmanViewController: TabmanTestViewController!
    
    //
    // MARK: Environment
    //
    
    override func setUp() {
        super.setUp()
        
        self.tabmanViewController = TabmanTestViewController()
        self.tabmanViewController.loadViewIfNeeded()
    }
    
    
    //
    // MARK: Tests
    //
    
    /// Test that the item count limit on a TabmanBar is correctly handled
    /// with valid data.
    func testItemCountLimit() {
        self.tabmanViewController.bar.style = .blockTabBar
        self.tabmanViewController.bar.items = [TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test")]
        
        XCTAssertTrue(self.tabmanViewController.tabmanBar?.items?.count == 5,
                      "TabmanBar itemCountLimit is not evaluated correctly for valid item count.")
    }
    
    /// Test that the item count limit on a TabmanBar is correctly handled
    /// with data that exceeds the limit.
    func testItemCountLimitExceeded() {
        self.tabmanViewController.bar.style = .blockTabBar
        self.tabmanViewController.bar.items = [TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test")]
        
        XCTAssertNil(self.tabmanViewController.tabmanBar?.items,
                     "TabmanBar itemCountLimit is not evaluated correctly for invalid item count.")
    }
}
