//
//  TabmanViewController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy
import AutoInsetter
import SnapKit

/// Page view controller with a bar indicator component.
open class TabmanViewController: PageboyViewController, PageboyViewControllerDelegate {
    
    // MARK: Properties
    
    private var activeDisplay: PagingStatusDisplay?
    
    // MARK: Init
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        delegate = self
    }
    
    // MARK: PageboyViewControllerDelegate
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    willScrollToPageAt index: PageIndex,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.2) {
                self.activeDisplay?.updateDisplay(for: CGFloat(index),
                                                  capacity: pageboyViewController.pageCount ?? 0)
            }
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollTo position: CGPoint,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        if !animated {
            let position = pageboyViewController.navigationOrientation == .horizontal ? position.x : position.y
            activeDisplay?.updateDisplay(for: position,
                                         capacity: pageboyViewController.pageCount ?? 0)
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollToPageAt index: PageIndex,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        activeDisplay?.updateDisplay(for: CGFloat(index),
                                     capacity: pageboyViewController.pageCount ?? 0)
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didReloadWith currentViewController: UIViewController,
                                    currentPageIndex: PageIndex) {
        
    }
}

public extension TabmanViewController {
    
    @discardableResult
    func addBar<LayoutType, BarButtonType>(_ bar: BarView<LayoutType, BarButtonType>,
                                           at location: BarLocation) -> BarView<LayoutType, BarButtonType> {
        self.activeDisplay = bar
        
        view.addSubview(bar)
        bar.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        return bar
    }
}
