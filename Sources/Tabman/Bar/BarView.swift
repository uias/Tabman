//
//  BarView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 28/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit
import Pageboy

internal protocol BarViewDelegate: class {
    
    func barView<LayoutType, BarButtonType>(_ bar: BarView<LayoutType, BarButtonType>,
                                            didRequestScrollToPageAt index: PageIndex)
}

open class BarView<LayoutType: BarLayout, BarButtonType: BarButton>: UIView, LayoutPerformer {
    
    // MARK: Properties
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    public private(set) lazy var layout = LayoutType(for: self)
    public private(set) var buttons: [BarButtonType]? {
        didSet {
            self.buttonStateController = BarButtonStateController(for: buttons)
            self.buttonInteractionController = BarButtonInteractionController(for: buttons, handler: self)
        }
    }
    private var buttonStateController: BarButtonStateController?
    private var buttonInteractionController: BarButtonInteractionController?
    
    public var indicatorStyle: BarIndicatorStyle = .default {
        didSet {
            updateIndicator(for: indicatorStyle)
        }
    }
    public private(set) lazy var indicator = BarIndicator.for(style: indicatorStyle)
    private var indicatorLayout: BarIndicatorLayout?
    private var indicatorContainer: UIView?
    
    private var indicatedPosition: CGFloat?
    
    internal weak var delegate: BarViewDelegate?
    
    // MARK: Init
    
    public required init() {
        super.init(frame: .zero)
        performLayout(in: self)
        
        self.backgroundColor = .lightGray
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("BarView does not support Interface Builder")
    }
    
    // MARK: Layout
    
    public private(set) var hasPerformedLayout = false
    
    public func performLayout(in view: UIView) {
        guard !hasPerformedLayout else {
            fatalError("performLayout() can only be called once.")
        }
        hasPerformedLayout = true
        
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
        layout.performLayout()
        
        layout(newIndicator: indicator)
    }
}

// MARK: - Customization
public extension BarView {
    
    public var contentInset: UIEdgeInsets {
        set {
            scrollView.contentInset = newValue
        } get {
            return scrollView.contentInset
        }
    }
}

// MARK: - Item population
public extension BarView {
    
    public func populate(with items: [BarItem],
                         configure: ((BarButtonType, BarItem) -> Void)? = nil) {
        
        let barButtons: [BarButtonType] = items.map({ item in
            let button = BarButtonType()
            button.populate(for: item)
            button.update(for: .unselected)
            return button
        })
        self.buttons = barButtons
        layout.clear()
        layout.populate(with: barButtons)
        
        if let configure = configure {
            for (index, button) in barButtons.enumerated() {
                let item = items[index]
                configure(button, item)
            }
        }
        
        // Update for indicated position
        if let indicatedPosition = self.indicatedPosition {
            updateDisplay(for: indicatedPosition, capacity: barButtons.count, direction: .neutral)
        }
    }
}

// MARK: - Paging Updates
extension BarView: PagingStatusDisplay {
    
    func updateDisplay(for pagePosition: CGFloat,
                       capacity: Int,
                       direction: NavigationDirection) {
        self.indicatedPosition = pagePosition
        layoutIfNeeded()
        
        let focusFrame = layout.barFocusRect(for: pagePosition, capacity: capacity)
        indicatorLayout?.update(for: focusFrame)
        
        buttonStateController?.update(for: pagePosition, direction: direction)
        
        scrollView.scrollRectToVisible(focusFrame, animated: false)
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
}

extension BarView: BarButtonInteractionHandler {
    
    func barButtonInteraction(controller: BarButtonInteractionController,
                              didHandlePressOf button: BarButton,
                              at index: Int) {
        delegate?.barView(self, didRequestScrollToPageAt: index)
    }
}
