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

class TabViewController: TabmanViewController, PageboyViewControllerDataSource {

    // MARK: Outlets
    
    @IBOutlet weak var upperSeparatorView: UIView!
    @IBOutlet weak var offsetLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var lowerSeparatorView: UIView!
    @IBOutlet weak var numberOfPagesLabel: UILabel!
    @IBOutlet weak var numberOfPagesStepper: UIStepper!
    @IBOutlet weak var settingsButton: CircularButton!
    @IBOutlet weak var gradientView: GradientView!

    // MARK: Properties

    var previousBarButton: UIBarButtonItem?
    var nextBarButton: UIBarButtonItem?
    
    private var viewControllers = [UIViewController]()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButtons()
        setUpGradientView()
        
        dataSource = self
        
        // bar customisation
        bar.location = .top
//        bar.style = .custom(type: CustomTabmanBar.self) // uncomment to use CustomTabmanBar as style.
        bar.appearance = PresetAppearanceConfigs.forStyle(self.bar.style, currentAppearance: self.bar.appearance)
        
        // updating
        numberOfPagesStepper.value = Double(numberOfViewControllers)
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
            navigationBar.tintColor = gradient.midColor
        }
    }

    private(set) var numberOfViewControllers: Int = 5 {
        didSet {
            reloadPages()
            updateStatusLabels()
        }
    }

    private var defaultNumberOfViewControllers: Int {
        switch bar.style {
        case .blockTabBar, .buttonBar:
            return 3
        default:
            return 5
        }
    }

    func resetNumberOfViewControllers() {
        numberOfViewControllers = defaultNumberOfViewControllers
    }
    
    // MARK: Actions
    
    @objc func firstPage(_ sender: UIBarButtonItem) {
        scrollToPage(.first, animated: true)
    }
    
    @objc func lastPage(_ sender: UIBarButtonItem) {
        scrollToPage(.last, animated: true)
    }

    @IBAction func numberOfPagesStepperDidChangeValue(_ sender: UIStepper) {
        numberOfViewControllers = Int(sender.value)
    }
    
    // MARK: PageboyViewControllerDataSource

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        initializeViewControllers(count: numberOfViewControllers)
        return numberOfViewControllers
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
