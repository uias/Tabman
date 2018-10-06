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

/// Page view controller with a bar indicator component.
open class TabmanViewController: PageboyViewController, PageboyViewControllerDelegate, BarDelegate {
    
    // MARK: Types
    
    public enum BarLocation {
        case top
        case bottom
        case custom(view: UIView, layout: ((UIView) -> Void)?)
    }
    
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
    
    // MARK: Pageboy Overrides
    
    open override func insertPage(at index: PageboyViewController.PageIndex,
                                  then updateBehavior: PageboyViewController.PageUpdateBehavior) {
        activeBars.forEach({ $0.reloadData(at: index...index, context: .insertion)})
        super.insertPage(at: index, then: updateBehavior)
    }
    
    open override func deletePage(at index: PageboyViewController.PageIndex,
                                  then updateBehavior: PageboyViewController.PageUpdateBehavior) {
        activeBars.forEach({ $0.reloadData(at: index...index, context: .deletion)})
        super.deletePage(at: index, then: updateBehavior)
    }
    
    // MARK: PageboyViewControllerDelegate
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    willScrollToPageAt index: PageIndex,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        if animated {
            updateActiveBars(to: CGFloat(index),
                             direction: direction,
                             animated: true)
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollTo position: CGPoint,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        if !animated {
            updateActiveBars(to: relativeCurrentPosition,
                             direction: direction,
                             animated: false)
        }
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollToPageAt index: PageIndex,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        updateActiveBars(to: CGFloat(index),
                         direction: direction,
                         animated: false)
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didReloadWith currentViewController: UIViewController,
                                    currentPageIndex: PageIndex) {
        guard let pageCount = pageboyViewController.pageCount else {
            return
        }
        activeBars.forEach({ $0.reloadData(at: 0...pageCount - 1, context: .full)})
    }
    
    // MARK: BarDelegate
    
    open func bar(_ bar: Bar,
                  didRequestScrollTo index: PageboyViewController.PageIndex) {
        scrollToPage(.at(index: index), animated: true, completion: nil)
    }
}

// MARK: - Bar Layout
public extension TabmanViewController {
    
    func addBar(_ bar: Bar,
                dataSource: BarDataSource,
                at location: BarLocation) {
        guard let barView = bar as? UIView else {
            fatalError("Bar is expected to inherit from UIView")
        }
        guard barView.superview == nil else {
            fatalError("Bar has already been added to view hierarchy.")
        }
        
        bar.dataSource = dataSource
        bar.delegate = self
        
        addActiveBar(bar)
        layoutView(barView, at: location)
        
        updateBar(bar, to: relativeCurrentPosition, animated: false)
        
        if let pageCount = self.pageCount {
            bar.reloadData(at: 0...pageCount - 1, context: .full)
        }
    }
    
    private func layoutContainers(in view: UIView) {
        
        topBarContainer.axis = .vertical
        view.addSubview(topBarContainer)
        
        topBarContainer.translatesAutoresizingMaskIntoConstraints = false
        var topConstraints = [
            topBarContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBarContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        if #available(iOS 11, *) {
            topConstraints.append(topBarContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        } else {
            topConstraints.append(topBarContainer.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor))
        }
        NSLayoutConstraint.activate(topConstraints)
        
        bottomBarContainer.axis = .vertical
        view.addSubview(bottomBarContainer)
        
        bottomBarContainer.translatesAutoresizingMaskIntoConstraints = false
        var bottomConstraints = [
            bottomBarContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBarContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        if #available(iOS 11, *) {
            bottomConstraints.append(bottomBarContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        } else {
            bottomConstraints.append(bottomBarContainer.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor))
        }
        NSLayoutConstraint.activate(bottomConstraints)
    }
    
    private func layoutView(_ view: UIView,
                            at location: BarLocation) {
        switch location {
        case .top:
            topBarContainer.addArrangedSubview(view)
        case .bottom:
            bottomBarContainer.addArrangedSubview(view)
        case .custom(let superview, let layout):
            superview.addSubview(view)
            if layout != nil {
                layout?(view)
            } else {
                view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                    view.topAnchor.constraint(equalTo: superview.topAnchor),
                    view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                    view.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
                    ])
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
                          direction: NavigationDirection = .neutral,
                          animated: Bool) {
        activeBars.forEach({ self.updateBar($0, to: position,
                                            direction: direction,
                                            animated: animated) })
    }
    
    func updateBar(_ bar: Bar,
                   to position: CGFloat?,
                   direction: NavigationDirection = .neutral,
                   animated: Bool) {
        let position = position ?? 0.0
        let capacity = self.pageCount ?? 0
        
        bar.update(for: position,
                   capacity: capacity,
                   direction: updateDirection(for: direction),
                   shouldAnimate: animated)
    }
    
    private func updateDirection(for navigationDirection: PageboyViewController.NavigationDirection) -> BarUpdateDirection {
        switch navigationDirection {
        case .forward:
            return .forward
        case .neutral:
            return .none
        case .reverse:
            return .reverse
        }
    }
}

internal extension TabmanViewController {
    
    var relativeCurrentPosition: CGFloat? {
        guard let position = self.currentPosition else {
            return nil
        }
        return self.navigationOrientation == .horizontal ? position.x : position.y
    }
    
    var transitionAnimationDuration: TimeInterval {
        return transition?.duration ?? 0.25
    }
}
