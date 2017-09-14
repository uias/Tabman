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
        
        self.bar.items = titles.flatMap({ Item(title: $0) })
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

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return testViewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return testViewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
