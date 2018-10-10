//
//  TMBarView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 01/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

/// View that conforms to be a Bar and displays BarItem objects in BarButtons inside a BarLayout.
open class TMBarView<LayoutType: TMBarLayout, ButtonType: TMBarButton, IndicatorType: TMBarIndicator>: UIView {
    
    // MARK: Types
    
    public typealias BarButtonCustomization = (ButtonType) -> Void
    
    public enum AnimationStyle {
        case progressive
        case snap
    }
    
    // MARK: Properties
    
    private let rootContainer = EdgeFadedView()
    private let scrollView = UIScrollView()
    private var grid: TMBarViewGrid!

    private var rootContainerTop: NSLayoutConstraint!
    private var rootContainerBottom: NSLayoutConstraint!
    
    private var indicatorLayoutHandler: TMBarIndicatorLayoutHandler?
    private var indicatedPosition: CGFloat?
    private lazy var contentInsetGuides = TMBarViewContentInsetGuides(for: self)
    
    // MARK: Core
    
    /// The layout that is currently active in the bar view.
    public private(set) lazy var layout = LayoutType()
    /// The bar buttons that are currently displayed in the bar view.
    public let buttons = TMBarButtonCollection<ButtonType>()
    /// The indicator that is displayed in this bar view.
    public let indicator = IndicatorType()
    /// Background of the BarView.
    ///
    /// Note: Default style is `UIColor.clear`.
    public var backgroundView = TMBarBackgroundView(style: .clear)
    
    /// Object that acts as a data source to the BarView.
    public weak var dataSource: TMBarDataSource?
    /**
     Object that acts as a delegate to the BarView.
     
     By default this is set to the `TabmanViewController` the bar is added to.
     **/
    public weak var delegate: TMBarDelegate?
    
    // MARK: Accessory Views
    
    /// Accessory View that is visible at the leading end of the bar view.
    open var leadingAccessoryView: UIView? {
        didSet {
            cleanUpOldAccessory(view: oldValue)
            updateAccessory(view: leadingAccessoryView,
                            at: .leading)
        }
    }
    /// Accessory View that is visible at the trailing end of the bar view.
    open var trailingAccessoryView: UIView? {
        didSet {
            cleanUpOldAccessory(view: oldValue)
            updateAccessory(view: trailingAccessoryView,
                            at: .trailing)
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
    /// Whether to fade the edges of the bar content.
    public var fadeEdges: Bool {
        set {
            rootContainer.showFade = newValue
        } get {
            return rootContainer.showFade
        }
    }
    
    // MARK: Init
    
    public required init() {
        super.init(frame: .zero)
        buttons.interactionHandler = self
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
        }
    }
    
    private func layout(in view: UIView) {
        var constraints = [NSLayoutConstraint]()
        
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(contentsOf: [
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        view.addSubview(rootContainer)
        rootContainer.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(contentsOf: [
            rootContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        self.rootContainerTop = rootContainer.topAnchor.constraint(equalTo: view.topAnchor)
        self.rootContainerBottom = view.bottomAnchor.constraint(equalTo: rootContainer.bottomAnchor)
        constraints.append(contentsOf: [rootContainerTop, rootContainerBottom])
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        rootContainer.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(contentsOf: [
            scrollView.leadingAnchor.constraint(equalTo: rootContainer.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: rootContainer.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: rootContainer.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: rootContainer.bottomAnchor)
            ])
        
        // Set up grid - stack views that content views are added to.
        self.grid = TMBarViewGrid(with: layout.view)
        scrollView.addSubview(grid)
        grid.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(contentsOf: [
            grid.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            grid.topAnchor.constraint(equalTo: scrollView.topAnchor),
            grid.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            grid.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            grid.heightAnchor.constraint(equalTo: rootContainer.heightAnchor)
            ])
        
        NSLayoutConstraint.activate(constraints)
        
        layout.layout(parent: self, insetGuides: contentInsetGuides)
        self.indicatorLayoutHandler = container(for: indicator).layoutHandler
    }
}

// MARK: - Bar
extension TMBarView: TMBar {
    
    public func reloadData(at indexes: ClosedRange<Int>,
                           context: TMBarReloadContext) {
        guard let dataSource = self.dataSource else {
            return
        }
        
        switch context {
        case .full, .insertion:
            
            var newButtons = [ButtonType]()
            for index in indexes.lowerBound ... indexes.upperBound {
                var item = dataSource.barItem(for: self, at: index)
                item.assignedIndex = index
                
                let button = ButtonType()
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
            }
            layout.remove(buttons: buttonsToRemove)
        }
        
        reloadIndicatorPosition()
    }
    
    public func update(for pagePosition: CGFloat,
                       capacity: Int,
                       direction: TMBarUpdateDirection,
                       shouldAnimate: Bool) {
        
        let (pagePosition, animated) = updateValues(for: animationStyle,
                                                    at: pagePosition,
                                                    shouldAnimate: shouldAnimate)
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
        let maxOffsetX = (scrollView.contentSize.width - bounds.size.width) + contentInset.right // maximum possible x offset
        let minOffsetX = -contentInset.left
        var contentOffset = CGPoint(x: (-centeredFocusFrame) + focusRect.origin.x, y: 0.0)
        
        contentOffset.x = max(minOffsetX, min(contentOffset.x, maxOffsetX)) // Constrain the offset to bounds
        
        let update = {
            self.layoutIfNeeded()
            
            self.buttons.stateController.update(for: pagePosition, direction: direction)
            self.scrollView.contentOffset = contentOffset
        }
        
        if animated {
            UIView.animate(withDuration: 0.25, animations: {
                update()
            })
        } else {
            update()
        }
    }

    private func updateValues(for style: AnimationStyle,
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
        switch indicator.displayStyle {
        case .footer:
            grid.addFooterSubview(container)
            
        case .header:
            grid.addHeaderSubview(container)
            
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
               shouldAnimate: true)
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

// MARK: - Accessory Views
private extension TMBarView {
    
    enum AccessoryLocation {
        case leading
        case trailing
    }
    
    func cleanUpOldAccessory(view: UIView?) {
        view?.removeFromSuperview()
    }
    
    func updateAccessory(view: UIView?, at location: AccessoryLocation) {
        guard let view = view else {
            return
        }
        
        switch location {
        case .leading:
            grid.addLeadingSubview(view)
        case .trailing:
            grid.addTrailingSubview(view)
        }
        reloadIndicatorPosition()
    }
}
