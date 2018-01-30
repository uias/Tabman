//
//  TabmanTestViewController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation
@testable import Tabman
import Pageboy

class TabmanTestViewController: TabmanViewController {
    
    fileprivate var viewControllers = [UIViewController]()
    
    var numberOfPages: Int = 5 {
        didSet {
            recreateViewControllers()
            self.reloadPages()
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recreateViewControllers()
        self.dataSource = self
    }
    
    private func recreateViewControllers() {
        var viewControllers = [UIViewController]()
        var barItems: [TabmanBar.Item] = []
        
        for index in 0 ..< numberOfPages {
            viewControllers.append(UIViewController())
            barItems.append(TabmanBar.Item(title: "Index \(index)"))
        }
        
        self.viewControllers = viewControllers
        self.bar.items = barItems
    }
}

extension TabmanTestViewController: PageboyViewControllerDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return numberOfPages
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
