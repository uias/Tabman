//
//  TabmanViewController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit
import Pageboy
import AutoInsetter

/// A view controller which embeds a `PageboyViewController` and provides the ability to add bars which
/// can directly manipulate, control and display the status of the page view controller. It also handles
/// automatic insetting of child view controller contents.
open class TabmanViewController: PageboyViewController, PageboyViewControllerDelegate, TMBarDelegate {
    
    // MARK: Types
    
    /// Location of the bar in the view controller.
    ///
    /// - top: Pin to the top of the safe area.
    /// - bottom: Pin to the bottom of the safe area.
    /// - custom: Add the view to a custom view and provide custom layout.
    ///           If no layout is provided, all edge anchors will be constrained
    ///           to the superview.
    public enum BarLocation {
        case top
        case bottom
        case custom(view: UIView, layout: ((UIView) -> Void)?)
    }
    
    // MARK: Views
    
    internal let topBarContainer = UIStackView()
    internal let bottomBarContainer = UIStackView()
    
    /// All bars that have been added to the view controller.
    public private(set) var bars = [TMBar]()
    
    // MARK: Layout
    
    private var requiredInsets: Insets?
    private let autoInsetter = AutoInsetter()
    /// Whether to automatically adjust child view controller content insets with bar geometry.
    ///
    /// This must be set before `viewDidLoad`, setting it after this point will result in no change.
    /// Default is `true`.
    public var automaticallyAdjustsChildInsets: Bool = true
    @available(*, unavailable)
    open override var automaticallyAdjustsScrollViewInsets: Bool {
        didSet {}
    }
    /// The insets that are required to safely layout content between the bars
    /// that have been added.
    ///
    /// This will only take account of bars that are added to the `.top` or `.bottom`
    /// locations - bars that are added to custom locations are responsible for handling
    /// their own insets.
    public var barInsets: UIEdgeInsets {
        return requiredInsets?.barInsets ?? .zero
    }
    /// The layout guide representing the portion of the view controller's view that is not
    /// obstructed by bars.
    public let barLayoutGuide: UILayoutGuide = {
        let guide = UILayoutGuide()
        guide.identifier = "barLayoutGuide"
        return guide
    }()
    private var barLayoutGuideTop: NSLayoutConstraint?
    private var barLayoutGuideBottom: NSLayoutConstraint?
    
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
        
        if automaticallyAdjustsChildInsets {
            autoInsetter.enable(for: self)
        }
        
        configureBarLayoutGuide(barLayoutGuide)
        layoutContainers(in: view)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setNeedsInsetsUpdate()
    }
    
    // MARK: Pageboy
    
    /// :nodoc:
    open override func insertPage(at index: PageboyViewController.PageIndex,
                                  then updateBehavior: PageboyViewController.PageUpdateBehavior) {
        bars.forEach({ $0.reloadData(at: index...index, context: .insertion) })
        super.insertPage(at: index, then: updateBehavior)
    }
    
    /// :nodoc:
    open override func deletePage(at index: PageboyViewController.PageIndex,
                                  then updateBehavior: PageboyViewController.PageUpdateBehavior) {
        bars.forEach({ $0.reloadData(at: index...index, context: .deletion) })
        super.deletePage(at: index, then: updateBehavior)
    }
    
    /// :nodoc:
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    willScrollToPageAt index: PageIndex,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        let viewController = dataSource?.viewController(for: self, at: index)
        setNeedsInsetsUpdate(to: viewController)
        
        if animated {
            updateActiveBars(to: CGFloat(index),
                             direction: direction,
                             animated: true)
        }
    }
    
    /// :nodoc:
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
    
    /// :nodoc:
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollToPageAt index: PageIndex,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        updateActiveBars(to: CGFloat(index),
                         direction: direction,
                         animated: false)
    }
    
    /// :nodoc:
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didReloadWith currentViewController: UIViewController,
                                    currentPageIndex: PageIndex) {
        setNeedsInsetsUpdate(to: currentViewController)
        
        guard let pageCount = pageboyViewController.pageCount else {
            return
        }
        bars.forEach({ $0.reloadData(at: 0...pageCount - 1, context: .full) })
    }
    
    // MARK: TMBarDelegate
    
    /// :nodoc:
    open func bar(_ bar: TMBar,
                  didRequestScrollTo index: PageboyViewController.PageIndex) {
        scrollToPage(.at(index: index), animated: true, completion: nil)
    }
}

// MARK: - Bar Layout
public extension TabmanViewController {
    
    /// Add a new `TMBar` to the view controller.
    ///
    /// - Parameters:
    ///   - bar: Bar to add.
    ///   - dataSource: Data source for the bar.
    ///   - location: Location of the bar.
    public func addBar(_ bar: TMBar,
                       dataSource: TMBarDataSource,
                       at location: BarLocation) {
        guard let barView = bar as? UIView else {
            fatalError("Bar is expected to inherit from UIView")
        }
        guard barView.superview == nil else {
            fatalError("Bar has already been added to view hierarchy.")
        }
        
        bar.dataSource = dataSource
        bar.delegate = self
        
        bars.append(bar)
        layoutView(barView, at: location)
        
        updateBar(bar, to: relativeCurrentPosition, animated: false)
        
        if let pageCount = self.pageCount, pageCount > 0 {
            bar.reloadData(at: 0...pageCount - 1, context: .full)
        }
    }
    
    /// Remove a `TMBar` from the view controller.
    ///
    /// - Parameter bar: Bar to remove.
    public func removeBar(_ bar: TMBar) {
        guard let index = bars.index(where: { $0 === bar }) else {
            return
        }
        
        bars.remove(at: index)
        (bar as? UIView)?.removeFromSuperview()
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
            bottomBarContainer.insertArrangedSubview(view, at: 0)
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
    
    private func configureBarLayoutGuide(_ guide: UILayoutGuide) {
        guard barLayoutGuide.owningView == nil else {
            return
        }
        
        view.addLayoutGuide(barLayoutGuide)
        let barLayoutGuideTop = barLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor)
        let barLayoutGuideBottom = view.bottomAnchor.constraint(equalTo: barLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            barLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            barLayoutGuideTop,
            barLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            barLayoutGuideBottom
            ])
        self.barLayoutGuideTop = barLayoutGuideTop
        self.barLayoutGuideBottom = barLayoutGuideBottom
    }
}

// MARK: - Bar Management
private extension TabmanViewController {
    
    func updateActiveBars(to position: CGFloat?,
                          direction: NavigationDirection = .neutral,
                          animated: Bool) {
        bars.forEach({ self.updateBar($0, to: position,
                                            direction: direction,
                                            animated: animated) })
    }
    
    func updateBar(_ bar: TMBar,
                   to position: CGFloat?,
                   direction: NavigationDirection = .neutral,
                   animated: Bool) {
        let position = position ?? 0.0
        let capacity = self.pageCount ?? 0
        let animation = TMAnimation(isEnabled: animated,
                                             duration: transition?.duration ?? 0.25)
        bar.update(for: position,
                   capacity: capacity,
                   direction: updateDirection(for: direction),
                   animation: animation)
    }
    
    func updateDirection(for navigationDirection: PageboyViewController.NavigationDirection) -> TMBarUpdateDirection {
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

// MARK: - Insetting
internal extension TabmanViewController {
    
    func setNeedsInsetsUpdate() {
        setNeedsInsetsUpdate(to: currentViewController)
    }
    
    func setNeedsInsetsUpdate(to viewController: UIViewController?) {
        let insets = Insets.for(tabmanViewController: self)
        self.requiredInsets = insets
        
        barLayoutGuideTop?.constant = insets.spec.allRequiredInsets.top
        barLayoutGuideBottom?.constant = insets.spec.allRequiredInsets.bottom

        // Don't inset TabmanViewController using AutoInsetter
        if viewController is TabmanViewController {
            if #available(iOS 11, *) {
                if viewController?.additionalSafeAreaInsets != insets.spec.additionalRequiredInsets {
                    viewController?.additionalSafeAreaInsets = insets.spec.additionalRequiredInsets
                }
            }
        } else {
            autoInsetter.inset(viewController, requiredInsetSpec: insets.spec)
        }
    }
}
