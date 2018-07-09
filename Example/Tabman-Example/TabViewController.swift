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
        
        let bar = addBar(Bar<ButtonBarLayout, SelectionStateBarButton>(), at: .top)
        let items = [BarItem(title: "Test"), BarItem(title: "TestTest"), BarItem(title: "TestTestTest"), BarItem(title: "TestTestTestTest"), BarItem(title: "TestTestTestTestTest")]
        bar.populate(with: items) { (button, item) in
//            button.color = .red
//            button.selectedColor = .green
            button.backgroundColor = .gray
        }
        
//        bar.layout.isScrollEnabled = false
//        bar.contentInset = UIEdgeInsets(top: 0.0, left: 12.0, bottom: 0.0, right: 12.0)
        
        let secondBar = addBar(Bar.TabBar(), at: .top)
        secondBar.populate(with: items)
        
        let thirdBar = addBar(Bar.ButtonBar(), at: .bottom)
        thirdBar.populate(with: items)
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
