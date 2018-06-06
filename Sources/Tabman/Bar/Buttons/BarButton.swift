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
    
    // MARK: Properties
    
    private let contentView = UIView()
    private var contentViewPins: Constraint?

    var contentInset: UIEdgeInsets = .zero {
        didSet {
            contentViewPins?.update(inset: contentInset)
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
        
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            self.contentViewPins = make.edges.equalToSuperview().constraint
        }
        
        performLayout(in: contentView)
    }
    
    // MARK: LayoutPerformer
    
    public private(set) var hasPerformedLayout = false
    
    public func performLayout(in view: UIView) {
        guard !hasPerformedLayout else {
            fatalError("performLayout() can only be called once.")
        }
    }
    
    // MARK: Item
    
    func populate(for item: BarItem) {
    }
}
