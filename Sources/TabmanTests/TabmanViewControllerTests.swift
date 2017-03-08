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
    
}
