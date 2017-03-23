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
    // MARK: Tests
    //
    
    /// Test that the item count limit on a TabmanBar is correctly handled
    /// with valid data.
    func testItemCountLimit() {
        self.tabmanViewController.bar.style = .blockTabBar
        self.tabmanViewController.bar.items = [TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test")]
        
        XCTAssertTrue(self.tabmanViewController.tabmanBar?.items?.count == 5,
                      "TabmanBar itemCountLimit is not evaluated correctly for valid item count.")
    }
    
    /// Test that the item count limit on a TabmanBar is correctly handled
    /// with data that exceeds the limit.
    func testItemCountLimitExceeded() {
        self.tabmanViewController.bar.style = .blockTabBar
        self.tabmanViewController.bar.items = [TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test"),
                                               TabmanBarItem(title: "test")]
        
        XCTAssertNil(self.tabmanViewController.tabmanBar?.items,
                     "TabmanBar itemCountLimit is not evaluated correctly for invalid item count.")
    }
    
    /// Test that TabmanViewController allows attaching of an external TabmanBar correctly.
    func testAttachExternalBar() {
        let testBar = TabmanTestBar()
        
        self.tabmanViewController.attach(bar: testBar)
        
        XCTAssertTrue(self.tabmanViewController.attachedTabmanBar != nil &&
            self.tabmanViewController.tabmanBar?.isHidden ?? false &&
            self.tabmanViewController.attachedTabmanBar!.dataSource != nil,
                      "Attaching external TabmanBar does not work correctly.")
    }
    
    /// Test that TabmanViewController handles detaching of an external TabmanBar correctly.
    func testDetachExternalBar() {
        let testBar = TabmanTestBar()
        self.tabmanViewController.attach(bar: testBar)
        
        let detachedBar = self.tabmanViewController.detachAttachedBar()
        
        XCTAssertTrue(self.tabmanViewController.attachedTabmanBar == nil &&
            self.tabmanViewController.tabmanBar?.isHidden ?? true == false &&
            detachedBar?.dataSource == nil,
                      "Detaching external TabmanBar does not clean up correctly.")
    }
    
    /// Test that TambmanViewController handles embedding internal TabmanBar in an external view.
    func testEmbedBarExternally() {
        let testView = UIView()
        self.tabmanViewController.embedBar(inView: testView)
        
        XCTAssertTrue(testView.subviews.count != 0 &&
            self.tabmanViewController.tabmanBar?.superview === testView &&
            self.tabmanViewController.embeddingView === testView,
                      "Embedding TabmanBar in an external view does not embed correctly.")
    }
    
    /// Test that TambmanViewController handles disembedding internal TabmanBar from an external view.
    func testDisembedBar() {
        let testView = UIView()
        self.tabmanViewController.embedBar(inView: testView)

        self.tabmanViewController.disembedBar()
        
        XCTAssertTrue(testView.subviews.count == 0 &&
            self.tabmanViewController.tabmanBar?.superview !== testView &&
            self.tabmanViewController.embeddingView == nil,
                      "Disembedding TabmanBar from an external view does not clean up correctly.")
    }
}
