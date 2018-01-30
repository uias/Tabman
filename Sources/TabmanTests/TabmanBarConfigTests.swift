//
//  TabmanBarConfigTests.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
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
        XCTAssert(self.tabmanViewController.tabmanBar is TabmanLineBar,
                  "TabmanBarConfig does not update style correctly.")
    }
    
    /// Test that the TabmanBarConfig updates bar location correctly.
    func testBarConfigLocationSet() {
        self.tabmanViewController.bar.location = .bottom
        XCTAssert(self.tabmanViewController.tabmanBar?.frame.origin.y ?? 0.0 > self.tabmanViewController.view.frame.size.height / 2.0,
                  "TabmanBarConfig does not update bar location correctly.")
    }
    
    /// Test that the TabmanBarConfig updates bar appearance correctly.
    func testBarConfigAppearanceSet() {
        let textColor = UIColor.yellow
        self.tabmanViewController.bar.appearance = TabmanBar.Appearance({ (appearance) in
            appearance.state.color = textColor
        })
        XCTAssert(self.tabmanViewController.bar.appearance?.state.color == textColor,
                  "TabmanBarConfig does not update bar appearance correctly.")
    }
    
    /// Test that the TabmanBarConfig allows image items to be set correctly.
    func testBarConfigImageItemsTest() {
        
        let barItemCount = self.tabmanViewController.bar.items?.count ?? 0
        
        var barItems: [TabmanBar.Item] = []
        for _ in 0 ..< barItemCount {
            barItems.append(TabmanBar.Item(image: UIImage()))
        }
        self.tabmanViewController.bar.items = barItems
        
        XCTAssertEqual(barItemCount, self.tabmanViewController.bar.items!.count,
                       "TabmanBarConfig does not support TabmanBar.Item with images correctly.")
    }
}
