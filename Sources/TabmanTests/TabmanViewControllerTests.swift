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
    // MARK: Lifecycle Tests
    //
    
    /// Test that the TabmanBarConfig can have items set.
    func testBarConfigItemsSet() {
        XCTAssert(self.tabmanViewController.bar.items?.count == self.tabmanViewController.numberOfPages,
                  "TabmanBarConfig does not get items set correctly.")
    }
}
