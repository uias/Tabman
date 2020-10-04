//
//  TabViewController.swift
//  Example
//
//  Created by Merrick Sapsford on 04/10/2020.
//

import UIKit
import Tabman
import Pageboy

class TabViewController: TabmanViewController, PageboyViewControllerDataSource, TMBarDataSource {

    // MARK: Properties
    
    private lazy var viewControllers: [UIViewController] = [
        ChildViewController(page: 1),
        ChildViewController(page: 2),
        ChildViewController(page: 3),
        ChildViewController(page: 4),
        ChildViewController(page: 5)
    ]
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        let bar = TMBarView.ButtonBar()
        
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 4.0, right: 16.0)
        bar.layout.interButtonSpacing = 24.0
        bar.indicator.weight = .light
        bar.indicator.cornerStyle = .eliptical
        bar.fadesContentEdges = true
        bar.spacing = 16.0
        
        bar.buttons.customize {
            $0.tintColor = UIColor.tabmanForeground.withAlphaComponent(0.4)
            $0.selectedTintColor = .tabmanForeground
        }
        bar.indicator.tintColor = .tabmanForeground
        
        addBar(bar.systemBar(), dataSource: self, at: .top)
    }

    // MARK: PageboyViewControllerDataSource
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
    
    // MARK: TMBarDataSource
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: "Page No. \(index + 1)")
    }
}
