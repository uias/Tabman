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
    
    private var activeDisplays = [PagingStatusDisplay]()
    
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
                self.updateActiveDisplays(to: CGFloat(index))
            }
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollTo position: CGPoint,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        if !animated {
            updateActiveDisplays(to: relativeCurrentPosition)
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollToPageAt index: PageIndex,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        updateActiveDisplays(to: CGFloat(index))
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didReloadWith currentViewController: UIViewController,
                                    currentPageIndex: PageIndex) {
        
    }
}

// MARK: - Bar Layout
public extension TabmanViewController {
    
    @discardableResult
    func addBar<LayoutType, BarButtonType>(_ bar: BarView<LayoutType, BarButtonType>,
                                           at location: BarLocation) -> BarView<LayoutType, BarButtonType> {
        addActiveDisplay(bar)
        
        view.addSubview(bar)
        bar.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        return bar
    }
}

// MARK: - Active Display management
private extension TabmanViewController {
    
    func addActiveDisplay(_ display: PagingStatusDisplay) {
        self.activeDisplays.append(display)
    }
    
    func updateActiveDisplays(to position: CGFloat?) {
        let position = position ?? 0.0
        let capacity = self.pageCount ?? 0
        
        activeDisplays.forEach({ $0.updateDisplay(for: position, capacity: capacity) })
    }
}

internal extension TabmanViewController {
    
    var relativeCurrentPosition: CGFloat? {
        guard let position = self.currentPosition else {
            return nil
        }
        return self.navigationOrientation == .horizontal ? position.x : position.y
    }
}
