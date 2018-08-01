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
        
        let bar = BarView<ButtonBarViewLayout, LabelBarButton>()
        addBar(bar, dataSource: self, at: .top)

        bar.background = .flat(color: .lightGray)

        bar.layout.contentMode = .fit
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)

        bar.layout.isScrollEnabled = false

        addBar(Bar.TabBar(), dataSource: self, at: .top)
        addBar(Bar.ButtonBar(), dataSource: self, at: .bottom)
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

extension TabViewController: BarDataSource {
    
    func barItem(for tabViewController: TabmanViewController, at index: Int) -> BarItem? {
        var title = "Test"
        for _ in 0 ..< index {
            title.append("Test")
        }
        return BarItem(title: title)
    }
}
