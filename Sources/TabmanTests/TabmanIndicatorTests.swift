//
//  TabmanIndicatorTests.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import XCTest
@testable import Tabman
import Pageboy

class TabmanIndicatorTests: XCTestCase {
    
    /// Test whether custom indicator style is initialized
    func testCustomIndicatorStyle() {
        let bar = TabmanTestBarWithIndicator()
        XCTAssert(bar.indicator is TabmanTestIndicator)
    }
}

private class TabmanTestBarWithIndicator: TabmanTestBar {
    
    override func defaultIndicatorStyle() -> TabmanIndicator.Style {
        return .custom(type: TabmanTestIndicator.self)
    }
}
