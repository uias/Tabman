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
    
    private var activeBars = [Bar]()
    
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
            let duration = self.transition?.duration ?? 0.25
            UIView.animate(withDuration: duration) {
                self.updateActiveBars(to: CGFloat(index), direction: direction)
            }
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollTo position: CGPoint,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        if !animated {
            updateActiveBars(to: relativeCurrentPosition, direction: direction)
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollToPageAt index: PageIndex,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        updateActiveBars(to: CGFloat(index), direction: direction)
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didReloadWith currentViewController: UIViewController,
                                    currentPageIndex: PageIndex) {
        activeBars.forEach({ $0.reloadData(for: self)})
    }
}

// MARK: - Bar Layout
public extension TabmanViewController {
    
    func addBar(_ bar: Bar,
                dataSource: BarDataSource,
                at location: BarLocation,
                layout: ((UIView) -> Void)? = nil) {
        guard let barView = bar as? UIView else {
            fatalError("Bar is expected to inherit from UIView")
        }
        guard barView.superview == nil else {
            fatalError("Bar has already been added to view hierarchy.")
        }
        
        bar.dataSource = dataSource
        bar.delegate = self
        
        addActiveBar(bar)
        layoutView(barView, at: location, customLayout: layout)
        
        updateBar(bar, to: relativeCurrentPosition)
        
        bar.reloadData(for: self)
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
    
    private func layoutView(_ view: UIView,
                            at location: BarLocation,
                            customLayout: ((UIView) -> Void)?) {
        switch location {
        case .top:
            topBarContainer.addArrangedSubview(view)
        case .bottom:
            bottomBarContainer.addArrangedSubview(view)
        case .custom(let view):
            view.addSubview(view)
            if customLayout != nil {
                customLayout?(view)
            } else {
                view.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
            }
        }
    }
}

// MARK: - Bar Management
private extension TabmanViewController {
    
    func addActiveBar(_ bar: Bar) {
        activeBars.append(bar)
    }
    
    func updateActiveBars(to position: CGFloat?,
                          direction: NavigationDirection = .neutral) {
        activeBars.forEach({ self.updateBar($0, to: position, direction: direction) })
    }
    
    func updateBar(_ bar: Bar,
                   to position: CGFloat?,
                   direction: NavigationDirection = .neutral) {
        let position = position ?? 0.0
        let capacity = self.pageCount ?? 0
        
        bar.update(for: position,
                   capacity: capacity,
                   direction: direction)
    }
}

// MARK: Bar Updates
extension TabmanViewController: BarDelegate {
    
    public func bar(_ bar: Bar, didRequestScrollToPageAt index: PageboyViewController.PageIndex) {
        scrollToPage(.at(index: index), animated: true, completion: nil)
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
