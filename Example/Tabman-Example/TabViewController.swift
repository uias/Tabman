//
//  TabViewController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 04/01/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class TabViewController: TabmanViewController {

    // MARK: Properties
    
    var viewControllers = [UIViewController]()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViewControllers(count: 5)
        
        self.dataSource = self
        
        let bar = addBar(BarViewTemplates.ButtonBar(), at: .top)
        let items = [BarItem(title: "Test"), BarItem(title: "TestTest"), BarItem(title: "TestTestTest"), BarItem(title: "TestTestTestTest"), BarItem(title: "TestTestTestTestTest")]
        bar.populate(with: items)
        
        bar.layout.isScrollEnabled = false
    }
}

extension TabViewController: PageboyViewControllerDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> Page? {
        return nil
    }
}

extension TabViewController {
    
    private func initializeViewControllers(count: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewControllers = [UIViewController]()
        
        for index in 0 ..< count {
            let viewController = storyboard.instantiateViewController(withIdentifier: "ChildViewController") as! ChildViewController
            viewController.index = index + 1
            
            viewControllers.append(viewController)
        }
        self.viewControllers = viewControllers
    }
}
