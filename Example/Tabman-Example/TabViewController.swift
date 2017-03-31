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

    // MARK: Constants

    let numberOfPages = 5
    let gradients: [GradientConfig] = [
        GradientConfig(topColor: UIColor(red:0.01, green:0.00, blue:0.18, alpha:1.0), bottomColor: UIColor(red:0.00, green:0.53, blue:0.80, alpha:1.0)),
        GradientConfig(topColor: UIColor(red:0.20, green:0.08, blue:0.00, alpha:1.0), bottomColor: UIColor(red:0.69, green:0.36, blue:0.00, alpha:1.0)),
        GradientConfig(topColor: UIColor(red:0.96, green:0.36, blue:0.26, alpha:1.0), bottomColor: UIColor(red:0.92, green:0.20, blue:0.29, alpha:1.0)),
        GradientConfig(topColor: UIColor(red:0.00, green:0.13, blue:0.05, alpha:1.0), bottomColor: UIColor(red:0.00, green:0.65, blue:0.33, alpha:1.0)),
        GradientConfig(topColor: UIColor(red:0.18, green:0.00, blue:0.20, alpha:1.0), bottomColor: UIColor(red:0.64, green:0.00, blue:0.66, alpha:1.0)),
        GradientConfig(topColor: UIColor(red:0.20, green:0.00, blue:0.00, alpha:1.0), bottomColor: UIColor(red:0.69, green:0.00, blue:0.00, alpha:1.0))
    ]
    
    // MARK: Outlets
    
    @IBOutlet weak var offsetLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!

    // MARK: Properties

    var previousBarButton: UIBarButtonItem?
    var nextBarButton: UIBarButtonItem?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBarButtons()
        self.view.sendSubview(toBack: self.gradientView)
        
        self.dataSource = self
        
        // bar customisation
//        self.bar.style = .custom(type: CustomTabmanBar.self) // uncomment to use CustomTabmanBar as style.
        self.bar.appearance = PresetAppearanceConfigs.forStyle(self.bar.style, currentAppearance: self.bar.appearance)
        
        // updating
        self.updateAppearance(pagePosition: self.currentPosition?.x ?? 0.0)
        self.updateStatusLabels()
        self.updateBarButtonStates(index: self.currentIndex ?? 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        segue.destination.transitioningDelegate = self
        
        if let navigationController = segue.destination as? SettingsNavigationController,
            let settingsViewController = navigationController.viewControllers.first as? SettingsViewController {
            settingsViewController.tabViewController = self
        }
        
        // use current gradient as tint
        if let navigationController = segue.destination as? UINavigationController,
            let navigationBar = navigationController.navigationBar as? TransparentNavigationBar {
            let gradient = self.gradients[self.currentIndex ?? 0]
            let color = self.interpolate(betweenColor: gradient.topColor,
                                         and: gradient.bottomColor,
                                         percent: 0.5)
            navigationBar.tintColor = color
        }
    }
    
    // MARK: Actions
    
    @objc func firstPage(_ sender: UIBarButtonItem) {
        self.scrollToPage(.first, animated: true)
    }
    
    @objc func lastPage(_ sender: UIBarButtonItem) {
        self.scrollToPage(.last, animated: true)
    }
    
    // MARK: PageboyViewControllerDataSource

    func numberOfPages(forBarStyle style: TabmanBar.Style) -> Int {
        switch style {
        case .blockTabBar, .buttonBar:
            return 2
        default:
            return 5
        }
    }
    
    func viewControllers(forPageboyViewController pageboyViewController: PageboyViewController) -> [UIViewController]? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewControllers = [UIViewController]()
        var tabBarItems = [TabmanBarItem]()
        for i in 0 ..< self.numberOfPages(forBarStyle: self.bar.style) {
            let viewController = storyboard.instantiateViewController(withIdentifier: "ChildViewController") as! ChildViewController
            viewController.index = i + 1
            
            tabBarItems.append(TabmanBarItem(title: String(format: "Page No. %i", viewController.index!)))
//            tabBarItems.append(TabmanBarItem(image: UIImage(named: "ic_home")!))
            
            viewControllers.append(viewController)
        }
        
        self.bar.items = tabBarItems
        return viewControllers
    }
    
    func defaultPageIndex(forPageboyViewController pageboyViewController: PageboyViewController) -> PageboyViewController.PageIndex? {
        return nil
    }
    
    // MARK: PageboyViewControllerDelegate
    
    private var targetIndex: Int?
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                        willScrollToPageAtIndex index: Int,
                                        direction: PageboyViewController.NavigationDirection,
                                        animated: Bool) {
        super.pageboyViewController(pageboyViewController,
                                    willScrollToPageAtIndex: index,
                                    direction: direction,
                                    animated: animated)
        
        self.targetIndex = index
    }
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollToPosition position: CGPoint,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {
        super.pageboyViewController(pageboyViewController,
                                    didScrollToPosition: position,
                                    direction: direction,
                                    animated: animated)
        
        self.updateAppearance(pagePosition: position.x)
        self.updateStatusLabels()
    }
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                        didScrollToPageAtIndex index: Int,
                                        direction: PageboyViewController.NavigationDirection,
                                        animated: Bool) {
        super.pageboyViewController(pageboyViewController,
                                    didScrollToPageAtIndex: index,
                                    direction: direction,
                                    animated: animated)
        
        self.updateAppearance(pagePosition: CGFloat(index))
        self.updateStatusLabels()
        self.updateBarButtonStates(index: index)
        
        self.targetIndex = nil
    }
}
