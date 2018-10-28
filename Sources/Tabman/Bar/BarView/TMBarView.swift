//
//  TMBarView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 01/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

// swiftlint:disable file_length

private struct TMBarViewDefaults {
    static let animationDuration: TimeInterval = 0.25
}

/// `TMBarView` is the default Tabman implementation of `TMBar`. A `UIView` that contains a `TMBarLayout` which displays
/// a collection of `TMBarButton`, and also a `TMBarIndicator`. The types of these three components are defined by constraints
/// in the `TMBarView` type definition.
open class TMBarView<LayoutType: TMBarLayout, ButtonType: TMBarButton, IndicatorType: TMBarIndicator>: UIView {
    
    // MARK: Types
    
    public typealias BarButtonCustomization = (ButtonType) -> Void
    
    public enum AnimationStyle {
        case progressive
        case snap
    }
    
    // MARK: Properties
    
    private let rootContentStack = UIStackView()
    
    private let scrollViewContainer = EdgeFadedView()
    private let scrollView = UIScrollView()
    private var grid: TMBarViewGrid!
    
    private let scrollHandler: TMBarViewScrollHandler
    
    private var rootContainerTop: NSLayoutConstraint!
    private var rootContainerBottom: NSLayoutConstraint!
    
    private var indicatorLayoutHandler: TMBarIndicatorLayoutHandler?
    private var indicatedPosition: CGFloat?
    private lazy var contentInsetGuides = TMBarViewContentInsetGuides(for: self)
    
    private var accessoryViews = [AccessoryLocation: UIView]()
    
    // MARK: Components
    
    /// `TMBarLayout` that dictates display and behavior of bar buttons and other bar view components.
    public private(set) lazy var layout = LayoutType()
    /// Collection of `TMBarButton` objects that directly map to the `TMBarItem`s provided by the `dataSource`.
    public let buttons = TMBarButtonCollection<ButtonType>()
    /// `TMBarIndicator` that is used to indicate the current bar index state.
    public let indicator = IndicatorType()
    /// Background view that appears behind all content in the bar view.
    ///
    /// Note: Default style is `TMBarBackgroundView.Style.clear`.
    public let backgroundView = TMBarBackgroundView(style: .clear)
    
    /// Items that are displayed in the bar.
    public private(set) var items: [TMBarItemable]?
    
    /// Object that acts as a data source to the BarView.
    public weak var dataSource: TMBarDataSource?
    /// Object that acts as a delegate to the BarView.
    ///
    /// By default this is set to the `TabmanViewController` the bar is added to.
    public weak var delegate: TMBarDelegate?
    
    // MARK: Accessory Views
    
    /// View to display on the left (or leading) edge of the bar.
    ///
    /// This view is within the scroll view and is subject to scroll off-screen
    /// with bar contents.
    open var leftAccessoryView: UIView? {
        didSet {
            setAccessoryView(leftAccessoryView, at: .leading)
        }
    }
    /// View to display on the left (or leading) edge of the bar.
    ///
    /// This view is not part of the scrollable bar contents and will be visible at all times.
    open var leftPinnedAccessoryView: UIView? {
        didSet {
            setAccessoryView(leftPinnedAccessoryView, at: .leadingPinned)
        }
    }
    /// View to display on the right (or trailing) edge of the bar.
    ///
    /// This view is within the scroll view and is subject to scroll off-screen
    /// with bar contents.
    open var rightAccessoryView: UIView? {
        didSet {
            setAccessoryView(rightAccessoryView, at: .trailing)
        }
    }
    /// View to display on the right (or trailing) edge of the bar.
    ///
    /// This view is not part of the scrollable bar contents and will be visible at all times.
    open var rightPinnedAccessoryView: UIView? {
        didSet {
            setAccessoryView(rightPinnedAccessoryView, at: .trailingPinned)
        }
    }
    
    // MARK: Customization
    
    /// Style to use when animating bar position updates.
    ///
    /// Options:
    /// - `.progressive`: The bar will seemlessly transition between each button in progressive steps.
    /// - `.snap`: The bar will transition between each button by rounding and snapping to each positional bound.
    ///
    /// Defaults to `.progressive`.
    public var animationStyle: AnimationStyle = .progressive
    /// Whether the bar contents should be allowed to be scrolled by the user.
    public var isScrollEnabled: Bool {
        set {
            scrollView.isScrollEnabled = newValue
        } get {
            return scrollView.isScrollEnabled
        }
    }
    /// Whether to fade the leading and trailing edges of the bar content to an alpha of 0.
    public var fadesContentEdges: Bool {
        set {
            scrollViewContainer.showFade = newValue
        } get {
            return scrollViewContainer.showFade
        }
    }
    
    // MARK: Init
    
    public required init() {
        self.scrollHandler = TMBarViewScrollHandler(for: scrollView)
        super.init(frame: .zero)
        
        buttons.interactionHandler = self
        scrollHandler.delegate = self
        layout(in: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("BarView does not support Interface Builder")
    }
    
    // MARK: Lifecycle
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        UIView.performWithoutAnimation {
            reloadIndicatorPosition()
            updateEdgeFades(for: scrollView)
        }
    }
    
    private func layout(in view: UIView) {
        layoutRootViews(in: view)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollViewContainer.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: scrollViewContainer.bottomAnchor)
            ])
        rootContentStack.addArrangedSubview(scrollViewContainer)
        
        // Set up grid - stack views that content views are added to.
        self.grid = TMBarViewGrid(with: layout.view)
        scrollView.addSubview(grid)
        grid.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            grid.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            grid.topAnchor.constraint(equalTo: scrollView.topAnchor),
            grid.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            grid.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            grid.heightAnchor.constraint(equalTo: rootContentStack.heightAnchor)
            ])
        
        layout.layout(parent: self, insetGuides: contentInsetGuides)
        self.indicatorLayoutHandler = container(for: indicator).layoutHandler
    }
    
    private func layoutRootViews(in view: UIView) {
        var constraints = [NSLayoutConstraint]()
        
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(contentsOf: [
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        rootContentStack.axis = .horizontal
        view.addSubview(rootContentStack)
        rootContentStack.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11, *) {
            constraints.append(contentsOf: [
                rootContentStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                rootContentStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
                ])
        } else {
            constraints.append(contentsOf: [
                rootContentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                rootContentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
        }
        self.rootContainerTop = rootContentStack.topAnchor.constraint(equalTo: view.topAnchor)
        self.rootContainerBottom = view.bottomAnchor.constraint(equalTo: rootContentStack.bottomAnchor)
        constraints.append(contentsOf: [rootContainerTop, rootContainerBottom])
        
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Bar
extension TMBarView: TMBar {
    
    public func reloadData(at indexes: ClosedRange<Int>,
                           context: TMBarReloadContext) {
        guard let dataSource = self.dataSource else {
            return
        }
        
        var items = self.items ?? [TMBarItemable]()
        
        switch context {
        case .full, .insertion:
            
            if context == .full && buttons.all.count > 0 { // remove existing buttons
                layout.remove(buttons: buttons.all)
                buttons.all.removeAll()
            }
            
            var newButtons = [ButtonType]()
            for index in indexes.lowerBound ... indexes.upperBound {
                let item = dataSource.barItem(for: self, at: index)
                items.insert(item, at: index)
                
                let button = ButtonType(for: item)
                button.populate(for: item)
                button.update(for: .unselected)
                newButtons.append(button)
            }
            
            buttons.all.insert(contentsOf: newButtons, at: indexes.lowerBound)
            layout.insert(buttons: newButtons, at: indexes.lowerBound)
            
        case .deletion:
            var buttonsToRemove = [ButtonType]()
            for index in indexes.lowerBound ... indexes.upperBound {
                let button = buttons.all[index]
                buttonsToRemove.append(button)
                items.remove(at: index)
            }
            layout.remove(buttons: buttonsToRemove)
        }
        
        self.items = items
        reloadIndicatorPosition()
    }
    
    public func update(for pagePosition: CGFloat,
                       capacity: Int,
                       direction: TMBarUpdateDirection,
                       animation: TMBarAnimation) {
        
        let (pagePosition, animated) = adjustValues(for: animationStyle,
                                                    at: pagePosition,
                                                    shouldAnimate: animation.isEnabled)
        self.indicatedPosition = pagePosition
        layoutIfNeeded()
        
        // Get focus area for updating indicator layout
        let focusArea = grid.convert(layout.focusArea(for: pagePosition, capacity: capacity), from: layout.view) // raw focus area in grid coordinate space
        let focusRect = TMBarViewFocusRect(rect: focusArea, at: pagePosition, capacity: capacity)
        indicatorLayoutHandler?.update(for: focusRect.rect(isProgressive: indicator.isProgressive,
                                                           overscrollBehavior: indicator.overscrollBehavior)) // Update indicator layout
        
        // New content offset for scroll view for focus frame
        // Designed to center the frame in the view if possible.
        let centeredFocusFrame = (bounds.size.width / 2) - (focusRect.size.width / 2) // focus frame centered in view
        let pinnedAccessoryWidth = (accessoryView(at: .leadingPinned)?.bounds.size.width ?? 0.0) + (accessoryView(at: .trailingPinned)?.bounds.size.width ?? 0.0)
        let maxOffsetX = (scrollView.contentSize.width - (bounds.size.width - pinnedAccessoryWidth)) + contentInset.right // maximum possible x offset
        let minOffsetX = -contentInset.left
        var contentOffset = CGPoint(x: (-centeredFocusFrame) + focusRect.origin.x, y: 0.0)
        
        contentOffset.x = max(minOffsetX, min(contentOffset.x, maxOffsetX)) // Constrain the offset to bounds
        
        let update = {
            self.layoutIfNeeded()
            
            self.buttons.stateController.update(for: pagePosition, direction: direction)
            self.scrollView.contentOffset = contentOffset
        }
        
        if animated {
            UIView.animate(withDuration: animation.duration, animations: {
                update()
            })
        } else {
            update()
        }
    }

    // MARK: Updating
    
    private func adjustValues(for style: AnimationStyle,
                              at position: CGFloat,
                              shouldAnimate: Bool) -> (CGFloat, Bool) {
        var position = position
        var animated = shouldAnimate
        switch style {
        case .snap:
            position = round(position)
            animated = true
            
        default: break
        }
        
        return (position, animated)
    }
    
    func updateEdgeFades(for scrollView: UIScrollView) {
        
        let contentSizeRatio = ((scrollView.contentSize.width - scrollView.bounds.size.width) / 2)
        
        let leadingOffsetRatio = max(0.0, min(1.0, (scrollView.contentOffset.x / contentSizeRatio)))
        let trailingOffsetRatio = max(0.0, min(1.0, ((scrollView.contentSize.width - scrollView.bounds.size.width) - scrollView.contentOffset.x) / contentSizeRatio))
        
        scrollViewContainer.leadingFade = leadingOffsetRatio
        scrollViewContainer.trailingFade = trailingOffsetRatio
    }
}

extension TMBarView: TMBarLayoutParent {
    
    var contentInset: UIEdgeInsets {
        set {
            let sanitizedContentInset = UIEdgeInsets(top: 0.0, left: newValue.left, bottom: 0.0, right: newValue.right)
            scrollView.contentInset = sanitizedContentInset
            scrollView.contentOffset.x -= sanitizedContentInset.left
            
            rootContainerTop.constant = newValue.top
            rootContainerBottom.constant = newValue.bottom
        } get {
            return UIEdgeInsets(top: rootContainerTop.constant,
                                left: scrollView.contentInset.left,
                                bottom: rootContainerBottom.constant,
                                right: scrollView.contentInset.right)
        }
    }
    
    var isPagingEnabled: Bool {
        set {
            scrollView.isPagingEnabled = newValue
        } get {
            return scrollView.isPagingEnabled
        }
    }
}

// MARK: - Indicator
extension TMBarView {
    
    /// Create a container for an indicator to be displayed in. Will also add the container to the view hierarchy.
    ///
    /// - Parameter indicator: Indicator to create container for.
    /// - Returns: Indicator container.
    private func container(for indicator: IndicatorType) -> TMBarIndicatorContainer<IndicatorType> {
        let container = TMBarIndicatorContainer(for: indicator)
        switch indicator.displayMode {
        case .top:
            grid.addTopSubview(container)
            
        case .bottom:
            grid.addBottomSubview(container)
            
        case .fill:
            scrollView.addSubview(container)
            container.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                container.topAnchor.constraint(equalTo: scrollView.topAnchor),
                container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
                ])
        }
        return container
    }
    
    private func reloadIndicatorPosition() {
        guard let indicatedPosition = self.indicatedPosition else {
            return
        }
        update(for: indicatedPosition,
               capacity: buttons.all.count,
               direction: .none,
               animation: TMBarAnimation(isEnabled: true,
                                               duration: TMBarViewDefaults.animationDuration))
    }
}

// MARK: - Interaction
extension TMBarView: TMBarButtonInteractionHandler {
    
    func barButtonInteraction(controller: TMBarButtonInteractionController,
                              didHandlePressOf button: TMBarButton,
                              at index: Int) {
        delegate?.bar(self, didRequestScrollTo: index)
    }
}

// MARK: - Accessory View Management
private extension TMBarView {

    enum AccessoryLocation: String {
        case leading
        case leadingPinned
        case trailing
        case trailingPinned
    }
    
    func setAccessoryView(_ view: UIView?,
                          at location: AccessoryLocation) {
        cleanUpOldAccessoryView(at: location)
        addAccessoryView(view, at: location)
    }
    
    private func accessoryView(at location: AccessoryLocation) -> UIView? {
        return accessoryViews[location]
    }
    
    private func cleanUpOldAccessoryView(at location: AccessoryLocation) {
        let view = accessoryView(at: location)
        view?.removeFromSuperview()
        accessoryViews[location] = nil
    }
    
    private func addAccessoryView(_ view: UIView?, at location: AccessoryLocation) {
        guard let view = view else {
            return
        }
        
        accessoryViews[location] = view
        switch location {
        case .leading:
            grid.addLeadingSubview(view)
        case .leadingPinned:
            rootContentStack.insertArrangedSubview(view, at: 0)
        case .trailing:
            grid.addTrailingSubview(view)
        case .trailingPinned:
            rootContentStack.insertArrangedSubview(view, at: rootContentStack.arrangedSubviews.count)
        }
        
        reloadIndicatorPosition()
    }
}

extension TMBarView: TMBarViewScrollHandlerDelegate {
    
    func barViewScrollHandler(_ handler: TMBarViewScrollHandler,
                              didReceiveUpdated contentOffset: CGPoint,
                              from scrollView: UIScrollView) {
        
        updateEdgeFades(for: scrollView)
    }
}
