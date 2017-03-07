//
//  TabmanButtonBarTests.swift
//  Tabman
//
//  Created by Merrick Sapsford on 27/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import XCTest
@testable import Tabman
import Pageboy

class TabmanButtonBarTests: XCTestCase {

    // MARK: Properties
    
    var buttonBar: TabmanButtonBar!
    
    // MARK: Lifecycle
    
    override func setUp() {
        super.setUp()
        
        self.buttonBar = TabmanButtonBar()
    }
}
