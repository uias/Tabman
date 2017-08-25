//
//  TabmanContainerViewController.swift
//  Tabman-Tests
//
//  Created by Merrick Sapsford on 13/08/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class TabmanContainerViewController: TabmanViewController {

    // MARK: Properties
    
    private(set) var testViewControllers = [UIViewController]()
    private(set) var titles = [String]()
    private(set) var test: TabmanTest!
    
    // MARK: Init
    
    init(with viewControllers: [UIViewController],
         titles: [String],
         for test: TabmanTest) {
        self.testViewControllers = viewControllers
        self.titles = titles
        self.test = test
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "\(test.title) Test"
        
        dataSource = self
    }
}

extension TabmanContainerViewController: PageboyViewControllerDataSource {

    func viewControllers(forPageboyViewController pageboyViewController: PageboyViewController) -> [UIViewController]? {
        var barItems = [Item]()
        titles.forEach { (title) in
            barItems.append(Item(title: title))
        }
        self.bar.items = barItems
        return testViewControllers
    }
    
    func defaultPageIndex(forPageboyViewController pageboyViewController: PageboyViewController) -> PageboyViewController.PageIndex? {
        return nil
    }
}
