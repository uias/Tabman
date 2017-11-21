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

    // MARK: Outlets
    
    @IBOutlet weak var offsetLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!

    // MARK: Properties

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var previousBarButton: UIBarButtonItem?
    var nextBarButton: UIBarButtonItem?
    
    private var viewControllers = [UIViewController]()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButtons()
        view.sendSubview(toBack: self.gradientView)
                
        dataSource = self
        
        // bar customisation
        bar.location = .top
//        bar.style = .custom(type: CustomTabmanBar.self) // uncomment to use CustomTabmanBar as style.
        bar.appearance = PresetAppearanceConfigs.forStyle(self.bar.style, currentAppearance: self.bar.appearance)
        
        bar.behaviors = [.autoHiding(.withOneItem)]
        
        // updating
        updateAppearance(pagePosition: currentPosition?.x ?? 0.0)
        updateStatusLabels()
        updateBarButtonStates(index: currentIndex ?? 0)
        
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
        scrollToPage(.first, animated: true)
    }
    
    @objc func lastPage(_ sender: UIBarButtonItem) {
        scrollToPage(.last, animated: true)
    }
    
    // MARK: PageboyViewControllerDataSource

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        var count = 0
        switch bar.style {
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

        bar.items = barItems
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
        
        targetIndex = index
    }

    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                        didScrollTo position: CGPoint,
                                        direction: PageboyViewController.NavigationDirection,
                                        animated: Bool) {
        super.pageboyViewController(pageboyViewController,
                                    didScrollTo: position,
                                    direction: direction,
                                    animated: animated)
        
        updateAppearance(pagePosition: position.x)
        updateStatusLabels()
    }
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                        didScrollToPageAt index: Int,
                                        direction: PageboyViewController.NavigationDirection,
                                        animated: Bool) {
        super.pageboyViewController(pageboyViewController,
                                    didScrollToPageAt: index,
                                    direction: direction,
                                    animated: animated)
        
        updateAppearance(pagePosition: CGFloat(index))
        updateStatusLabels()
        updateBarButtonStates(index: index)
        
        targetIndex = nil
    }
}
