//
//  BarView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 28/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

open class BarView<LayoutType: BarLayout, BarButtonType: BarButton>: UIView, LayoutPerformer {
    
    // MARK: Properties
    
    private let scrollView = UIScrollView()
    
    public private(set) lazy var layout = LayoutType(for: self)
    public private(set) var buttons: [BarButtonType]?
    
    public private(set) lazy var indicator = BarIndicator.for(style: indicatorStyle)
    public var indicatorStyle: BarIndicatorStyle = .default {
        didSet {
            updateIndicator(for: indicatorStyle)
        }
    }
    
    // MARK: Init
    
    public required init() {
        super.init(frame: .zero)
        performLayout(in: self)
        
        self.backgroundColor = .red
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
        
        let layoutContainer = layout.container
        scrollView.addSubview(layoutContainer)
        layoutContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(view)
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
    }
}

// MARK: - Paging Updates
extension BarView: PagingStatusDisplay {
    
    func updateDisplay(for pagePosition: CGFloat, capacity: Int) {
        let focusFrame = layout.barFocusRect(for: pagePosition, capacity: capacity)
        print(focusFrame)
    }
}

// MARK: - Indicator management
extension BarView {
    
    private func updateIndicator(for style: BarIndicatorStyle) {
        
    }
}
