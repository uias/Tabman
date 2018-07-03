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
    
    private let topBarContainer = UIStackView()
    private let bottomBarContainer = UIStackView()
    
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
    
    // MARK: Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        layoutContainers(in: view)
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
            updateActiveDisplays(to: relativeCurrentPosition, direction: direction)
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollToPageAt index: PageIndex,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        updateActiveDisplays(to: CGFloat(index), direction: direction)
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
        guard bar.superview == nil else {
            fatalError("Bar has already been added to view hierarchy.")
        }
        
        addActiveDisplay(bar)
        layoutBar(bar, at: location)
        
        updateActiveDisplay(bar, to: relativeCurrentPosition)
        
        return bar
    }
    
    private func layoutContainers(in view: UIView) {
        
        topBarContainer.axis = .vertical
        view.addSubview(topBarContainer)
        topBarContainer.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalToSuperview()
            }
        }
        
        bottomBarContainer.axis = .vertical
        view.addSubview(bottomBarContainer)
        bottomBarContainer.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            
            if #available(iOS 11, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            } else {
                make.bottom.equalToSuperview()
            }
        }
    }
    
    private func layoutBar<LayoutType, BarButtonType>(_ bar: BarView<LayoutType, BarButtonType>,
                                                      at location: BarLocation) {
        switch location {
        case .top:
            topBarContainer.addArrangedSubview(bar)
        case .bottom:
            bottomBarContainer.addArrangedSubview(bar)
        }
    }
}

// MARK: - Active Display management
private extension TabmanViewController {
    
    func addActiveDisplay(_ display: PagingStatusDisplay) {
        self.activeDisplays.append(display)
    }
    
    func updateActiveDisplays(to position: CGFloat?,
                              direction: NavigationDirection = .neutral) {
        activeDisplays.forEach({ self.updateActiveDisplay($0, to: position, direction: direction) })
    }
    
    func updateActiveDisplay(_ display: PagingStatusDisplay,
                             to position: CGFloat?,
                             direction: NavigationDirection = .neutral) {
        let position = position ?? 0.0
        let capacity = self.pageCount ?? 0
        
        display.updateDisplay(for: position,
                              capacity: capacity,
                              direction: direction)
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
