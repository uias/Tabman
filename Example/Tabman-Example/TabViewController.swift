//
//  TabViewController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 04/01/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class TabViewController: TabmanViewController, PageboyViewControllerDataSource {

    // MARK: Types
    
    struct GradientConfig {
        let topColor: UIColor
        let bottomColor: UIColor
        
        static var defaultGradient: GradientConfig {
            return GradientConfig(topColor: .black, bottomColor: .black)
        }
    }
    
    //
    // MARK: Constants
    //
    
    let numberOfPages = 5
    
    let gradients: [GradientConfig] = [
        GradientConfig(topColor: UIColor(red:0.01, green:0.00, blue:0.18, alpha:1.0), bottomColor: UIColor(red:0.00, green:0.53, blue:0.80, alpha:1.0)),
        GradientConfig(topColor: UIColor(red:0.20, green:0.08, blue:0.00, alpha:1.0), bottomColor: UIColor(red:0.69, green:0.36, blue:0.00, alpha:1.0)),
        GradientConfig(topColor: UIColor(red:0.00, green:0.13, blue:0.05, alpha:1.0), bottomColor: UIColor(red:0.00, green:0.65, blue:0.33, alpha:1.0)),
        GradientConfig(topColor: UIColor(red:0.18, green:0.00, blue:0.20, alpha:1.0), bottomColor: UIColor(red:0.64, green:0.00, blue:0.66, alpha:1.0)),
        GradientConfig(topColor: UIColor(red:0.20, green:0.00, blue:0.00, alpha:1.0), bottomColor: UIColor(red:0.69, green:0.00, blue:0.00, alpha:1.0))
    ]
    
    //
    // MARK: Outlets
    //
    
    @IBOutlet weak var offsetLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!

    //
    // MARK: Properties
    //
    
    var previousBarButton: UIBarButtonItem?
    var nextBarButton: UIBarButtonItem?
    
    //
    // MARK: Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBarButtons()
        self.view.sendSubview(toBack: self.gradientView)
        
        self.dataSource = self
        self.delegate = self
        
        self.updateAppearance(pageOffset: self.currentPosition?.x ?? 0.0)
        self.updateStatusLabels()
        self.updateBarButtonStates(index: self.currentIndex ?? 0)
    }
    
    func updateStatusLabels() {
        self.offsetLabel.text = "Current Position: " + String(format: "%.3f", self.currentPosition?.x ?? 0.0)
        self.pageLabel.text = "Current Page: " + String(describing: self.currentIndex ?? 0)
    }
    
    // 
    // MARK: Actions
    //
    
    @objc func nextPage(_ sender: UIBarButtonItem) {
        self.scrollToPage(.next, animated: true)
    }
    
    @objc func previousPage(_ sender: UIBarButtonItem) {
        self.scrollToPage(.previous, animated: true)
    }
    
    //
    // MARK: PageboyViewControllerDataSource
    //
    
    func viewControllers(forPageboyViewController pageboyViewController: PageboyViewController) -> [UIViewController]? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewControllers = [UIViewController]()
        var tabBarItems = [TabmanBarItem]()
        for i in 0..<numberOfPages {
            let viewController = storyboard.instantiateViewController(withIdentifier: "ChildViewController") as! ChildViewController
            viewController.index = i + 1
            tabBarItems.append(TabmanBarItem(title: String(format: "Page Index %i", viewController.index!)))
            viewControllers.append(viewController)
        }
        
        self.tabBarItems = tabBarItems
        return viewControllers
    }
    
    func defaultPageIndex(forPageboyViewController pageboyViewController: PageboyViewController) -> PageboyViewController.PageIndex? {
        return .atIndex(index: 2)
    }
    
    //
    // MARK: PageboyViewControllerDelegate
    //
    
    
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollToPosition position: CGPoint,
                               direction: PageboyViewController.NavigationDirection) {
        super.pageboyViewController(pageboyViewController,
                                    didScrollToPosition: position,
                                    direction: direction)
        
        self.updateAppearance(pageOffset: position.x)
        self.updateStatusLabels()
    }
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               willScrollToPageAtIndex index: Int,
                               direction: PageboyViewController.NavigationDirection) {
        super.pageboyViewController(pageboyViewController,
                                    willScrollToPageAtIndex: index,
                                    direction: direction)
        
        self.updateBarButtonStates(index: index)
    }
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollToPageWithIndex index: Int,
                               direction: PageboyViewController.NavigationDirection) {
        super.pageboyViewController(pageboyViewController,
                                    didScrollToPageWithIndex: index,
                                    direction: direction)
        
        self.updateAppearance(pageOffset: CGFloat(index))
        self.updateStatusLabels()
        
        self.updateBarButtonStates(index: index)
    }
}

