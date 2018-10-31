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
    
    @IBOutlet private weak var footerViewContainer: UIView!
    @IBOutlet private weak var statusView: PageStatusView!
    var gradient: GradientViewController? {
        return parent as? GradientViewController
    }
    
    private var activeBulletinManager: BLTNItemManager?
    
    let bar = TMBar.ButtonBar()
    
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
        
        // Pin footer views (status and settings button etc.) to the bar layout guide
        // so that they will move when bars are added to the view.
        barLayoutGuide.bottomAnchor.constraint(equalTo: footerViewContainer.bottomAnchor, constant: 20.0).isActive = true
        
        dataSource = self

        // Customization
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 4.0, right: 16.0)
        bar.indicator.weight = .light
        bar.indicator.cornerStyle = .eliptical
        bar.fadesContentEdges = true
        
        // Add a '+' button the trailing end of the bar to insert more pages.
        let plusButton = CircularBarActionButton(action: .add)
        plusButton.addTarget(self, action: #selector(insertPage(_:)), for: .touchUpInside)
        plusButton.tintColor = .white
        bar.rightAccessoryView = plusButton
        
        // Add the bar to the view controller - wrapping it in a `TMSystemBar`.
        addBar(bar.systemBar(),
               dataSource: self,
               at: .top)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Customize bar colors for gradient background.
        let tintColor = gradient?.activeColors?.first ?? .white
        bar.buttons.customize { (button) in
            button.selectedTintColor = tintColor
            button.tintColor = tintColor.withAlphaComponent(0.4)
        }
        bar.indicator.tintColor = tintColor
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

extension TabPageViewController: TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: "Page No. \(index + 1)",
                         image: EmojiBarButton.random().image)
    }
}

private extension TabPageViewController {
    
    private func gradientOffset(for position: CGFloat) -> CGFloat {
        return position / CGFloat((self.pageCount ?? 1) - 1)
    }
}
