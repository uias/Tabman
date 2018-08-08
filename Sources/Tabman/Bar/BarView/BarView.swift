//
//  BarView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 01/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit
import Pageboy

open class BarView<LayoutType: BarLayout, ButtonType: BarButton, IndicatorType: BarIndicator>: UIView, LayoutPerformer {
    
    // MARK: Types
    
    public typealias BarButtonCustomization = (ButtonType) -> Void
    
    // MARK: Properties
    
    private let edgeFadeView = EdgeFadedView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    /// The layout that is currently active in the bar view.
    public private(set) lazy var layout = LayoutType(contentView: scrollView)
    /// The bar buttons that are currently displayed in the bar view.
    public let buttons = BarButtons<ButtonType>()

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
    private var indicatorLayout: BarIndicatorLayout?
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
    
    // MARK: LayoutPerformer
    
    public private(set) var hasPerformedLayout = false
    
    public func performLayout(in view: UIView) {
        guard !hasPerformedLayout else {
            fatalError("performLayout() can only be called once.")
        }
        hasPerformedLayout = true
        
        view.addSubview(backgroundContainer)
        backgroundContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        updateBackground(for: background.backgroundView)
        
        view.addSubview(edgeFadeView)
        edgeFadeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        edgeFadeView.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        stackView.axis = .vertical
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(view)
        }
        
        let layoutContainer = layout.container
        stackView.addArrangedSubview(layoutContainer)
        layout.performLayout(contentInsetGuides: contentInsetGuides)
        
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
            
            buttons.collection.insert(contentsOf: newButtons, at: indexes.lowerBound)
            layout.insert(buttons: newButtons, at: indexes.lowerBound)
            
        case .deletion:
            var buttonsToRemove = [ButtonType]()
            for index in indexes.lowerBound ... indexes.upperBound {
                let button = buttons.collection[index]
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
        indicatorLayout?.update(for: focusFrame)
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
            edgeFadeView.showFade = newValue
        } get {
            return edgeFadeView.showFade
        }
    }
    
    private func updateBackground(for view: UIView?) {
        backgroundContainer.removeAllSubviews()
        guard let view = view else {
            return
        }
        
        backgroundContainer.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Indicator management
extension BarView {
    
    private func updateIndicator(to newIndicator: BarIndicator) {
        clearUp(oldIndicator: self.indicator, container: self.indicatorContainer)
        
        layout(newIndicator: newIndicator)
    }
    
    // MARK: Clean Up
    
    private func clearUp(oldIndicator: BarIndicator, container: UIView?) {
        oldIndicator.removeFromSuperview()
        container?.removeFromSuperview()
    }
    
    // MARK: Layout
    
    private func layout(newIndicator: BarIndicator) {
        let container = layoutContainer(for: newIndicator)
        let layout = layoutIndicator(newIndicator, in: container)
        
        self.indicatorContainer = container
        self.indicatorLayout = layout
        
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
            container.snp.makeConstraints { (make) in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
        return container
    }
    
    private func layoutIndicator(_ indicator: BarIndicator, in container: UIView) -> BarIndicatorLayout {
        container.addSubview(indicator)
        
        var leading: NSLayoutConstraint?
        var width: NSLayoutConstraint?
        var height: NSLayoutConstraint?
        
        indicator.snp.makeConstraints { (make) in
            leading = make.leading.equalToSuperview().constraint.layoutConstraints.first
            width = make.width.equalTo(0).constraint.layoutConstraints.first
            height = make.height.equalTo(0).priority(500).constraint.layoutConstraints.first
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        return BarIndicatorLayout(leading: leading, width: width, height: height)
    }
    
    private func reloadIndicatorPosition() {
        guard let indicatedPosition = self.indicatedPosition else {
            return
        }
        update(for: indicatedPosition,
               capacity: buttons.collection.count,
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
