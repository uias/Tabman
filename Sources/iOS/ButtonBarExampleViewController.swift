//
//  ButtonBarExampleViewController.swift
//  Example
//
//  Created by Merrick Sapsford on 04/10/2020.
//

import UIKit
import Tabman
import Pageboy

class ButtonBarExampleViewController: TabmanViewController, PageboyViewControllerDataSource, TMBarDataSource {

    // MARK: Properties
    
    /// View controllers that will be displayed in page view controller.
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
        
        // Set PageboyViewControllerDataSource dataSource to configure page view controller.
        dataSource = self
        
        // Create a bar
        let bar = TMBarView.ButtonBar()
        
        // Customize bar properties including layout and other styling.
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 4.0, right: 16.0)
        bar.layout.interButtonSpacing = 24.0
        bar.indicator.weight = .light
        bar.indicator.cornerStyle = .eliptical
        bar.fadesContentEdges = true
        bar.spacing = 16.0
        
        // Set tint colors for the bar buttons and indicator.
        bar.buttons.customize {
            $0.tintColor = UIColor.tabmanForeground.withAlphaComponent(0.4)
            $0.selectedTintColor = .tabmanForeground
            $0.adjustsFontForContentSizeCategory = true
        }
        bar.indicator.tintColor = .tabmanForeground
        
        // Add bar to the view - as a .systemBar() to add UIKit style system background views.
        addBar(bar.systemBar(), dataSource: self, at: .top)
    }

    // MARK: PageboyViewControllerDataSource
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        viewControllers.count // How many view controllers to display in the page view controller.
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        viewControllers[index] // View controller to display at a specific index for the page view controller.
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil // Default page to display in the page view controller (nil equals default/first index).
    }
    
    // MARK: TMBarDataSource
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: "Page No. \(index + 1)") // Item to display for a specific index in the bar.
    }
}
