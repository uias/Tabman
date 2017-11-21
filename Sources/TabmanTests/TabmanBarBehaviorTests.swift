//
//  TabmanBarBehaviorTests.swift
//  TabmanTests
//
//  Created by Merrick Sapsford on 21/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import XCTest
@testable import Tabman
import Pageboy

class TabmanBarBehaviorTests: TabmanViewControllerTests {

    func testBehaviorEngineUpdates() {
        let config = tabmanViewController.bar
        let bar = tabmanViewController.activeTabmanBar
        
        let initialBehaviors = bar?.behaviorEngine.activeBehaviors ?? []
        
        config.behaviors = [.autoHide(.always)]
        
        let finalBehaviors = bar?.behaviorEngine.activeBehaviors ?? []
        
        XCTAssertTrue(initialBehaviors.count < finalBehaviors.count,
                      "Behaviors don't get added when set on the bar config")
    }
}
