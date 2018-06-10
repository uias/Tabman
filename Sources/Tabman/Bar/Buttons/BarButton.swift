//
//  BarButton.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

open class BarButton: UIControl, LayoutPerformer {
    
    // MARK: Types
    
    public enum SelectionState {
        case unselected
        case partial(delta: CGFloat)
        case selected
    }
    
    // MARK: Properties
    
    private let contentView = UIView()
    private var contentViewPins: Constraint?

    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            contentViewPins?.update(inset: contentInset)
        }
    }
    
    public var selectionState: SelectionState = .unselected {
        didSet {
            update(for: selectionState)
        }
    }
    
    // MARK: Init
    
    public required init() {
        super.init(frame: .zero)
        initialize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        
        backgroundColor = .green
        
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            self.contentViewPins = make.edges.equalToSuperview().constraint
        }
        
        performLayout(in: contentView)
    }
    
    // MARK: LayoutPerformer
    
    public private(set) var hasPerformedLayout = false
    
    open func performLayout(in view: UIView) {
        guard !hasPerformedLayout else {
            fatalError("performLayout() can only be called once.")
        }
    }
    
    // MARK: Lifecycle
    
    open func populate(for item: BarItem) {
    }
    
    open func update(for selectionState: SelectionState) {
        let minimumAlpha: CGFloat = 0.5
        let alpha = minimumAlpha + (selectionState.rawValue * minimumAlpha)
        
        self.alpha = alpha
    }
}

extension BarButton.SelectionState {
    
    var rawValue: CGFloat {
        switch self {
        case .unselected:
            return 0.0
        case .partial(let delta):
            return delta
        case .selected:
            return 1.0
        }
    }
}
