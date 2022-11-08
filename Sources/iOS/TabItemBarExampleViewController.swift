//
//  TabItemBarExampleViewController.swift
//  Example iOS
//
//  Created by Divyesh Makwana on 6/25/21.
//

import UIKit
import Tabman
import Pageboy

class TabItemBarExampleViewController: TabmanViewController, PageboyViewControllerDataSource, TMBarDataSource {

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
        let bar = TMBarView<TMConstrainedHorizontalBarLayout, TMTabItemBarButton, TMBarIndicator.None>()
        
        // Customize bar properties including layout and other styling.
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 4.0, right: 8.0)
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
        return TMBarItem(title: "Page No. \(index + 1)", image: UIImage.star ?? UIImage(), selectedImage: UIImage.starFilled ?? UIImage())
    }
}


// MARK: - Star Image Extensions
extension UIImage {
    
    class var star: UIImage? {
        if #available(iOS 13, *) {
            return UIImage(systemName: "star")
        } else {
            return nil
        }
    }
    
    class var starFilled: UIImage? {
        if #available(iOS 13, *) {
            return UIImage(systemName: "star.fill")
        } else {
            return nil
        }
    }
}
