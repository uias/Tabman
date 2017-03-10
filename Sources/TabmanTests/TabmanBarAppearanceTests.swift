//
//  TabmanBarAppearanceTests.swift
//  Tabman
//
//  Created by Merrick Sapsford on 10/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import XCTest
@testable import Tabman
import Pageboy

class TabmanBarAppearanceTests: TabmanViewControllerTests {
    
    func testPreferredIndicatorStyleConformance() {
        self.tabmanViewController.bar.style = .buttonBar
        self.tabmanViewController.bar.appearance = TabmanBar.Appearance({ (appearance) in
            appearance.indicator.preferredStyle = .dot
        })
        
        let indicator = self.tabmanViewController.tabmanBar!.indicator!
        let type = TabmanIndicator.Style.dot.rawType!
        
        XCTAssertTrue(type(of: indicator) == type,
                      "preferredIndicatorStyle is incorrectly ignored to when using .buttonBar style")
    }
    
    func testPreferredIndicatorStyleIgnorance() {
        self.tabmanViewController.bar.style = .blockTabBar
        self.tabmanViewController.bar.appearance = TabmanBar.Appearance({ (appearance) in
            appearance.indicator.preferredStyle = .dot
        })
        
        let indicator = self.tabmanViewController.tabmanBar!.indicator!
        let type = TabmanIndicator.Style.dot.rawType!
        
        XCTAssertFalse(type(of: indicator) == type,
                       "preferredIndicatorStyle is incorrectly conformed to when using .blockTabBar style")
    }
}
