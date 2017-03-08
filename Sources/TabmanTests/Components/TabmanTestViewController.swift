//
//  TabmanTestViewController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
@testable import Tabman
import Pageboy

class TabmanTestViewController: TabmanViewController {
    
    var numberOfPages: Int = 5 {
        didSet {
            self.reloadPages()
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
    }
}

extension TabmanTestViewController: PageboyViewControllerDataSource {
    
    func viewControllers(forPageboyViewController pageboyViewController: PageboyViewController) -> [UIViewController]? {
        var viewControllers = [UIViewController]()
        var barItems = [TabmanBarItem]()
        
        for index in 0 ..< self.numberOfPages {
            viewControllers.append(UIViewController())
            barItems.append(TabmanBarItem(title: "Index \(index)"))
        }
        self.bar.items = barItems
        
        return viewControllers
    }
    
    func defaultPageIndex(forPageboyViewController pageboyViewController: PageboyViewController) -> PageboyViewController.PageIndex? {
        return nil
    }
}
