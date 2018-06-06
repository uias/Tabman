//
//  BarView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 28/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

public protocol BarViewDataSource: class {
    
    func item<LayoutType, BarButtonType>(for bar: BarView<LayoutType, BarButtonType>,
                                         at index: Int) -> BarItem
}

internal protocol BarViewMetricsProvider: class {
    
    var numberOfItems: Int { get }
}

open class BarView<LayoutType: BarLayout, BarButtonType: BarButton>: UIView, LayoutPerformer {
    
    // MARK: Properties
    
    public let layout = LayoutType()
    
    public weak var dataSource: BarViewDataSource? {
        didSet {
            reloadData()
        }
    }
    weak var metricsProvider: BarViewMetricsProvider?
    
    // MARK: Init
    
    public required init() {
        super.init(frame: .zero)
        performLayout(in: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("BarView does not support Interface Builder")
    }
    
    // MARK: Construction
    
    public private(set) var hasPerformedLayout = false
    
    public func performLayout(in view: UIView) {
        guard !hasPerformedLayout else {
            fatalError("performLayout() can only be called once.")
        }
        
        let layoutContainer = layout.container
        view.addSubview(layoutContainer)
        layoutContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

internal extension BarView {
    
    func reloadData() {
        guard let numberOfPages = metricsProvider?.numberOfItems else {
            return
        }
        
        
    }
}
