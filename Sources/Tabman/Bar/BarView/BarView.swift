//
//  BarView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 01/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

open class BarView<LayoutType: BarLayout, ButtonType: BarButton, IndicatorType: BarIndicator>: UIView, LayoutPerformer {
    
    // MARK: Types
    
    public typealias BarButtonCustomization = (ButtonType) -> Void
    
    // MARK: Properties
    
    private let rootContainer = EdgeFadedView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private var rootContainerTop: NSLayoutConstraint!
    private var rootContainerBottom: NSLayoutConstraint!
    
    /// The layout that is currently active in the bar view.
    public private(set) lazy var layout = LayoutType()
    /// The bar buttons that are currently displayed in the bar view.
    public let buttons = BarButtonCollection<ButtonType>()

    /// Object that acts as a data source to the BarView.
    public weak var dataSource: BarDataSource?
    /**
     Object that acts as a delegate to the BarView.
     
     By default this is set to the `TabmanViewController` the bar is added to.
     **/
    public weak var delegate: BarDelegate?
    
    private lazy var contentInsetGuides = BarViewContentInsetGuides(for: self)
    
    private let backgroundContainer = UIView()
    public var background: BarViewBackground = .flat(color: .white) {
        didSet {
            updateBackground(for: background.backgroundView)
        }
    }

    public let indicator = IndicatorType()
    private var indicatorLayoutHandler: BarIndicatorLayoutHandler?
    private var indicatorContainer: UIView?
    
    private var indicatedPosition: CGFloat?
    
    // MARK: Init
    
    public required init() {
        super.init(frame: .zero)
        buttons.interactionHandler = self
        performLayout(in: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("BarView does not support Interface Builder")
    }
    
    // MARK: Lifecycle
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        reloadIndicatorPosition()
    }
    
    // MARK: LayoutPerformer
    
    public private(set) var hasPerformedLayout = false
    
    public func performLayout(in view: UIView) {
        guard !hasPerformedLayout else {
            fatalError("performLayout() can only be called once.")
        }
        hasPerformedLayout = true
        var constraints = [NSLayoutConstraint]()
        
        view.addSubview(backgroundContainer)
        backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(contentsOf: [
            backgroundContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundContainer.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        updateBackground(for: background.backgroundView)
        
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
        
        stackView.axis = .vertical
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(contentsOf: [
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: rootContainer.heightAnchor)
            ])
        
        NSLayoutConstraint.activate(constraints)
        
        let layoutContainer = layout.container
        stackView.addArrangedSubview(layoutContainer)
        layout.performLayout(parent: self, insetGuides: contentInsetGuides)
        
        layout(newIndicator: indicator)
    }
}

// MARK: - Bar
extension BarView: Bar {
    
    public func reloadData(for viewController: TabmanViewController,
                           at indexes: ClosedRange<Int>,
                           context: BarReloadContext) {
        guard let dataSource = self.dataSource else {
            return
        }
        
        switch context {
        case .full, .insertion:
            
            var newButtons = [ButtonType]()
            for index in indexes.lowerBound ... indexes.upperBound {
                var item = dataSource.barItem(for: viewController, at: index)
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
                       direction: PageboyViewController.NavigationDirection) {
        self.indicatedPosition = pagePosition
        layoutIfNeeded()
        
        let focusFrame = layout.barFocusRect(for: pagePosition, capacity: capacity)
        indicatorLayoutHandler?.update(for: focusFrame)
        layoutIfNeeded()
        
        buttons.stateController.update(for: pagePosition, direction: direction)
        
        scrollView.scrollRectToVisible(focusFrame, animated: false)
    }
}

// MARK: - Customization
public extension BarView {
    
    /// Whether the layout should be allowed to be scrolled by the user.
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
    
    private func updateBackground(for view: UIView?) {
        backgroundContainer.removeAllSubviews()
        guard let view = view else {
            return
        }
        
        backgroundContainer.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor),
            view.topAnchor.constraint(equalTo: backgroundContainer.topAnchor),
            view.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor)
            ])
    }
}

// MARK: - Indicator management
extension BarView {
    
    private func layout(newIndicator: BarIndicator) {
        let container = layoutContainer(for: newIndicator)
        let layout = layoutIndicator(newIndicator, in: container)
        
        self.indicatorContainer = container
        self.indicatorLayoutHandler = layout
        
        newIndicator.backgroundColor = .orange
    }
    
    private func layoutContainer(for indicator: BarIndicator) -> UIView {
        let container = UIView()
        switch indicator.displayStyle {
        case .footer:
            stackView.addArrangedSubview(container)
            
        case .header:
            stackView.insertArrangedSubview(container, at: 0)
            
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
    
    private func layoutIndicator(_ indicator: BarIndicator, in container: UIView) -> BarIndicatorLayoutHandler {
        container.addSubview(indicator)
        
        let leading = indicator.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        let top = indicator.topAnchor.constraint(equalTo: container.topAnchor)
        let bottom = indicator.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        
        let width = indicator.widthAnchor.constraint(equalToConstant: 0.0)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([leading, top, bottom, width])
        
        return BarIndicatorLayoutHandler(leading: leading, width: width)
    }
    
    private func reloadIndicatorPosition() {
        guard let indicatedPosition = self.indicatedPosition else {
            return
        }
        update(for: indicatedPosition,
               capacity: buttons.all.count,
               direction: .neutral)
    }
}

extension BarView: BarButtonInteractionHandler {
    
    func barButtonInteraction(controller: BarButtonInteractionController,
                              didHandlePressOf button: BarButton,
                              at index: Int) {
        delegate?.bar(self, didRequestScrollToPageAt: index)
    }
}

extension BarView: BarLayoutParent {
    
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
