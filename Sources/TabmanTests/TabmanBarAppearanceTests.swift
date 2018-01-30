//
//  TabmanBarAppearanceTests.swift
//  Tabman
//
//  Created by Merrick Sapsford on 10/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
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
        
        self.tabmanViewController.bar.appearance = TabmanBar.Appearance({ (appearance) in
            appearance.indicator.preferredStyle = .chevron
        })
        
        let indicator = self.tabmanViewController.tabmanBar!.indicator!
        let indicatorType = TabmanIndicator.Style.chevron.rawType!
        
        XCTAssertTrue(type(of: indicator) == indicatorType,
                      "preferredIndicatorStyle is incorrectly ignored when using .buttonBar style")
    }
    
    func testPreferredIndicatorStyleIgnorance() {
        self.tabmanViewController.bar.style = .blockTabBar
        self.tabmanViewController.bar.appearance = TabmanBar.Appearance({ (appearance) in
            appearance.indicator.preferredStyle = .dot
        })
        
        let indicator = self.tabmanViewController.tabmanBar!.indicator!
        let indicatorType = TabmanIndicator.Style.dot.rawType!
        
        XCTAssertFalse(type(of: indicator) == indicatorType,
                       "preferredIndicatorStyle is incorrectly conformed to when using .blockTabBar style")
    }
    
    func testBackgroundStyleConformance() {
        
        self.tabmanViewController.bar.appearance = TabmanBar.Appearance({ (appearance) in
            appearance.style.background = .blur(style: .dark)
        })
        
        let backgroundStyle = self.tabmanViewController.tabmanBar!.backgroundView.style
        XCTAssertTrue(backgroundStyle != .none,
                      "background style in TabmanBarAppearance is ignored incorrectly")
    }
}
