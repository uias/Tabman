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

open class BarView<LayoutType: BarViewLayout, BarButtonType: BarButton>: UIView, LayoutPerformer {
    
    // MARK: Types
    
    public typealias BarButtonCustomization = (BarButtonType) -> Void
    
    // MARK: Properties
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    public private(set) lazy var layout = LayoutType(contentView: scrollView)
    public let buttons = BarButtons<BarButtonType>()

    public weak var dataSource: BarDataSource?
    public weak var delegate: BarDelegate?
    
    private lazy var contentInsetGuides = BarViewContentInsetGuides(for: self)
    
    private let backgroundContainer = UIView()
    public var background: BarViewBackground = .flat(color: .white) {
        didSet {
            updateBackground(for: background.backgroundView)
        }
    }
    open override var backgroundColor: UIColor? {
        set {
            fatalError("Use .background instead")
        } get {
            return nil
        }
    }

    public var indicatorStyle: BarIndicatorStyle = .default {
        didSet {
            updateIndicator(for: indicatorStyle)
        }
    }
    public private(set) lazy var indicator = BarIndicator.for(style: indicatorStyle)
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
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
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
            
            var newButtons = [BarButtonType]()
            for index in indexes.lowerBound ... indexes.upperBound {
                var item = dataSource.barItem(for: viewController, at: index)
                item.assignedIndex = index
                
                let button = BarButtonType()
                button.populate(for: item)
                button.update(for: .unselected)
                newButtons.append(button)
            }
            
            buttons.collection.insert(contentsOf: newButtons, at: indexes.lowerBound)
            layout.insert(barButtons: newButtons, at: indexes.lowerBound)
            
        case .deletion:
            var buttonsToRemove = [BarButtonType]()
            for index in indexes.lowerBound ... indexes.upperBound {
                let button = buttons.collection[index]
                buttonsToRemove.append(button)
            }
            layout.remove(barButtons: buttonsToRemove)
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
    
    private func updateIndicator(for style: BarIndicatorStyle) {
        let indicator = BarIndicator.for(style: style)
        updateIndicator(to: indicator)
    }
    
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
