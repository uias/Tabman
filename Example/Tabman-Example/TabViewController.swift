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
        GradientConfig(topColor: UIColor(red:0.00, green:0.45, blue:1.00, alpha:1.0), bottomColor: UIColor(red:0.00, green:0.78, blue:1.00, alpha:1.0)),
        GradientConfig(topColor: UIColor(red:0.97, green:0.21, blue:0.00, alpha:1.0), bottomColor: UIColor(red:1.00, green:0.55, blue:0.00, alpha:1.0)),
        GradientConfig(topColor: UIColor(red:0.01, green:0.11, blue:0.47, alpha:1.0), bottomColor: UIColor(red:0.02, green:0.46, blue:0.90, alpha:1.0)),
        GradientConfig(topColor: UIColor(red:0.20, green:0.20, blue:0.60, alpha:1.0), bottomColor: UIColor(red:1.00, green:0.00, blue:0.80, alpha:1.0)),
        GradientConfig(topColor: UIColor(red:0.06, green:0.20, blue:0.26, alpha:1.0), bottomColor: UIColor(red:0.20, green:0.91, blue:0.62, alpha:1.0))
    ]
    
    // MARK: Outlets
    
    @IBOutlet weak var offsetLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!

    // MARK: Properties

    var previousBarButton: UIBarButtonItem?
    var nextBarButton: UIBarButtonItem?
    
    private var viewControllers = [UIViewController]()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBarButtons()
        self.view.sendSubview(toBack: self.gradientView)
        
        self.dataSource = self
        
        // bar customisation
        self.bar.location = .top
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

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        var count = 0
        switch self.bar.style {
        case .blockTabBar, .buttonBar:
            count = 3
        default:
            count = 5
        }
        
        initializeViewControllers(count: count)
        return count
    }
    
    private func initializeViewControllers(count: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewControllers = [UIViewController]()
        var barItems = [Item]()
        
        for index in 0 ..< count {
            let viewController = storyboard.instantiateViewController(withIdentifier: "ChildViewController") as! ChildViewController
            viewController.index = index + 1
            barItems.append(Item(title: "Page No. \(index + 1)"))
            
            viewControllers.append(viewController)
        }

        self.bar.items = barItems
        self.viewControllers = viewControllers
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return self.viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    // MARK: PageboyViewControllerDelegate
    
    private var targetIndex: Int?
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                        willScrollToPageAt index: Int,
                                        direction: PageboyViewController.NavigationDirection,
                                        animated: Bool) {
        super.pageboyViewController(pageboyViewController,
                                    willScrollToPageAt: index,
                                    direction: direction,
                                    animated: animated)
        
        self.targetIndex = index
    }

    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                        didScrollTo position: CGPoint,
                                        direction: PageboyViewController.NavigationDirection,
                                        animated: Bool) {
        super.pageboyViewController(pageboyViewController,
                                    didScrollTo: position,
                                    direction: direction,
                                    animated: animated)
        
        self.updateAppearance(pagePosition: position.x)
        self.updateStatusLabels()
    }
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                        didScrollToPageAt index: Int,
                                        direction: PageboyViewController.NavigationDirection,
                                        animated: Bool) {
        super.pageboyViewController(pageboyViewController,
                                    didScrollToPageAt: index,
                                    direction: direction,
                                    animated: animated)
        
        self.updateAppearance(pagePosition: CGFloat(index))
        self.updateStatusLabels()
        self.updateBarButtonStates(index: index)
        
        self.targetIndex = nil
    }
}
