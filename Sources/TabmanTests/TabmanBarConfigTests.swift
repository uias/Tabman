//
//  TabmanBarConfigTests.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import XCTest
@testable import Tabman
import Pageboy

class TabmanBarConfigTests: TabmanViewControllerTests {
    
    /// Test that the TabmanBarConfig sets items correctly.
    func testBarConfigItemsSet() {
        XCTAssert(self.tabmanViewController.bar.items?.count == self.tabmanViewController.numberOfPages,
                  "TabmanBarConfig does not set items correctly.")
    }
    
    /// Test that the TabmanBarConfig updates style correctly.
    func testBarConfigStyleSet() {
        self.tabmanViewController.bar.style = .bar
        XCTAssert(self.tabmanViewController.tabmanBar is TabmanOnlyBar,
                  "TabmanBarConfig does not update style correctly.")
    }
    
    /// Test that the TabmanBarConfig updates bar location correctly.
    func testBarConfigLocationSet() {
        self.tabmanViewController.bar.location = .bottom
        XCTAssert(self.tabmanViewController.tabmanBar?.frame.origin.y ?? 0.0 > self.tabmanViewController.view.frame.size.height / 2.0,
                  "TabmanBarConfig does not update bar location correctly.")
    }
}
