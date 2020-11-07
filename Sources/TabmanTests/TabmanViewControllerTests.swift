//
//  TabmanViewControllerTests.swift
//  TabmanTests
//
//  Created by Merrick Sapsford on 01/09/2018.
//  Copyright © 2020 UI At Six. All rights reserved.
//

import XCTest
import UIKit
@testable import Tabman
import Pageboy

class TabmanViewControllerTests: XCTestCase {
    
    var viewController: TabmanViewController!
    var barDataSource: TMBarDataSource!
    
    // MARK: Set Up
    
    override func setUp() {
        super.setUp()
        
        self.viewController = MockTabmanViewController()
        self.barDataSource = MockBarDataSource()
        
        viewController.view.frame = CGRect(x: 0.0, y: 0.0,
                                           width: 375,
                                           height: 667)
        viewController.view.layoutIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.viewController = nil
        self.barDataSource = nil
    }
    
    // MARK: Tests
    
    /// Test that bar can be added to view controller.
    func testAddBar() {
        
        let bar = MockBarView()
        viewController.addBar(bar,
                              dataSource: barDataSource,
                              at: .top)
        XCTAssertNotNil(bar.superview)
    }
    
    /// Test that bar added to .top location is at top of view controller.
    func testAddBarToTop() {
        
        let bar = MockBarView()
        viewController.addBar(bar,
                              dataSource: barDataSource,
                              at: .top)
        
        let frame = viewController.view.convert(bar.frame,
                                                from: bar.superview)
        XCTAssert(frame.origin.y < viewController.view.frame.size.height / 2)
    }
    
    /// Test that bar added to .bottom location is at bottom of view controller.
    func testAddBarToBottom() {
        
        let bar = MockBarView()
        viewController.addBar(bar,
                              dataSource: barDataSource,
                              at: .bottom)
        
        let frame = viewController.view.convert(bar.frame,
                                                from: bar.superview)
        XCTAssert(frame.origin.y > viewController.view.frame.size.height / 2)
    }
    
    /// Test that bar added to .custom location is in custom view.
    func testAddBarToCustomView() {
        
        let customContainer = UIView()
        
        let bar = MockBarView()
        viewController.addBar(bar,
                              dataSource: barDataSource,
                              at: .custom(view: customContainer, layout: nil))
        
        XCTAssertTrue(customContainer.subviews.first === bar)
    }
}
