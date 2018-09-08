//
//  PageViewController.swift
//  Pageboy-Example
//
//  Created by Merrick Sapsford on 04/01/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy
import BLTNBoard

class PageViewController: PageboyViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var statusView: PageStatusView!
    var gradient: GradientViewController? {
        return parent as? GradientViewController
    }
    var previousBarButton: UIBarButtonItem?
    var nextBarButton: UIBarButtonItem?
    
    private var activeBulletinManager: BLTNItemManager?
    
    lazy var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        for i in 0 ..< 5 {
            viewControllers.append(makeChildViewController(at: i))
        }
        return viewControllers
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        gradient?.gradients = Gradients.all
        addBarButtonsIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBulletin(makeIntroBulletinManager())
    }
    
    // MARK: Actions
    
    @objc func nextPage(_ sender: UIBarButtonItem) {
        scrollToPage(.next, animated: true)
    }
    
    @objc func previousPage(_ sender: UIBarButtonItem) {
        scrollToPage(.previous, animated: true)
    }
    
    // MARK: Bulletins
    
    func showBulletin(_ manager: BLTNItemManager?) {
        if let manager = manager {
            self.activeBulletinManager = manager
            manager.showBulletin(above: self)
        }
    }
    
    // MARK: View Controllers
    
    func makeChildViewController(at index: Int?) -> ChildViewController {
        let storyboard = UIStoryboard(name: "Pageboy", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: "ChildViewController") as! ChildViewController
    }
}

// MARK: PageboyViewControllerDataSource
extension PageViewController: PageboyViewControllerDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        let count = viewControllers.count
        statusView.numberOfPages = count
        return count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

// MARK: PageboyViewControllerDelegate
extension PageViewController: PageboyViewControllerDelegate {
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               willScrollToPageAt index: PageboyViewController.PageIndex,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {
        print("willScrollToPageAtIndex: \(index)")
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollTo position: CGPoint,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {
//        print("didScrollToPosition: \(position)")
        
        let relativePosition = navigationOrientation == .vertical ? position.y : position.x
        gradient?.gradientOffset = relativePosition
        statusView.currentPosition = relativePosition
        
        updateBarButtonsForCurrentIndex()
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollToPageAt index: PageboyViewController.PageIndex,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {
//        print("didScrollToPageAtIndex: \(index)")

        gradient?.gradientOffset = CGFloat(index)
        statusView.currentIndex = index
        updateBarButtonsForCurrentIndex()
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didReloadWith currentViewController: UIViewController,
                               currentPageIndex: PageIndex) {
    }
}

