//
//  TabPageViewController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 04/01/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy
import Tabman
import BLTNBoard

class TabPageViewController: TabmanViewController {
    
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
        for _ in 0 ..< 5 {
            viewControllers.append(makeChildViewController())
        }
        return viewControllers
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        let bar = Bar.ButtonBar()
        
        // Customization
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
//        bar.buttons.customize { (button) in
//            button.selectedColor = .white
//            button.color = UIColor.white.withAlphaComponent(0.4)
//        }
//        bar.indicator.tintColor = .white
//        bar.indicator.weight = .light
        
        let plusButton = CircularBarActionButton(action: .add)
        plusButton.addTarget(self, action: #selector(insertPage(_:)), for: .touchUpInside)
        plusButton.tintColor = .white
        bar.trailingAccessoryView = plusButton
        
        addBar(TabmanNavigationBar(for: bar),
               dataSource: self,
               at: .top)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    @objc func insertPage(_ sender: UIBarButtonItem) {
        let index = viewControllers.count
        viewControllers.append(makeChildViewController())
        insertPage(at: index, then: .scrollToUpdate)
    }
    
    // MARK: Bulletins
    
    func showBulletin(_ manager: BLTNItemManager?) {
        if let manager = manager {
            self.activeBulletinManager = manager
            manager.showBulletin(above: self)
        }
    }
    
    // MARK: View Controllers
    
    func makeChildViewController() -> ChildViewController {
        let storyboard = UIStoryboard(name: "Tabman", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: "ChildViewController") as! ChildViewController
    }
    
    // MARK: PageboyViewControllerDelegate
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               willScrollToPageAt index: PageboyViewController.PageIndex,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {
        super.pageboyViewController(pageboyViewController,
                                    willScrollToPageAt: index,
                                    direction: direction,
                                    animated: animated)
//        print("willScrollToPageAtIndex: \(index)")
    }
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollTo position: CGPoint,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {
        super.pageboyViewController(pageboyViewController,
                                    didScrollTo: position,
                                    direction: direction,
                                    animated: animated)
        //        print("didScrollToPosition: \(position)")
        
        let relativePosition = navigationOrientation == .vertical ? position.y : position.x
        gradient?.gradientOffset = gradientOffset(for: relativePosition)
        statusView.currentPosition = relativePosition
        
        updateBarButtonsForCurrentIndex()
    }
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollToPageAt index: PageboyViewController.PageIndex,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {
        super.pageboyViewController(pageboyViewController,
                                    didScrollToPageAt: index,
                                    direction: direction,
                                    animated: animated)
        
        //        print("didScrollToPageAtIndex: \(index)")
        
        gradient?.gradientOffset = gradientOffset(for: CGFloat(index))
        statusView.currentIndex = index
        updateBarButtonsForCurrentIndex()
    }
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didReloadWith currentViewController: UIViewController,
                               currentPageIndex: PageIndex) {
        super.pageboyViewController(pageboyViewController,
                                    didReloadWith: currentViewController,
                                    currentPageIndex: currentPageIndex)
    }
}

// MARK: PageboyViewControllerDataSource
extension TabPageViewController: PageboyViewControllerDataSource {
    
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

extension TabPageViewController: BarDataSource {
    
    func barItem(for bar: Bar, at index: Int) -> BarItem {
        return BarItem(title: "Page No. \(index + 1)")
    }
}

private extension TabPageViewController {
    
    private func gradientOffset(for position: CGFloat) -> CGFloat {
        return position / CGFloat((self.pageCount ?? 1) - 1)
    }
}
