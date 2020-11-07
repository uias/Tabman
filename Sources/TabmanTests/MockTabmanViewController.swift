//
//  MockTabmanViewController.swift
//  TabmanTests
//
//  Created by Merrick Sapsford on 01/09/2018.
//  Copyright © 2020 UI At Six. All rights reserved.
//

import Tabman
import UIKit
import Pageboy

class MockTabmanViewController: TabmanViewController {
    
    let viewControllers: [UIViewController]
    let defaultIndex: Int?
    
    // MARK: Init
    
    init(pageCount: Int = 5, defaultIndex: Int? = nil) {
        
        var viewControllers = [UIViewController]()
        for _ in 0 ..< pageCount {
            viewControllers.append(UIViewController())
        }
        self.viewControllers = viewControllers
        self.defaultIndex = defaultIndex
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Supported")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
    }
}

extension MockTabmanViewController: PageboyViewControllerDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        if let defaultIndex = self.defaultIndex {
            return .at(index: defaultIndex)
        }
        return nil
    }
}
