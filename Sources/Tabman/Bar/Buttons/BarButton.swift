//
//  BarButton.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

open class BarButton: UIControl, LayoutPerformer {
    
    // MARK: Init
    
    public required init() {
        super.init(frame: .zero)
        performLayout(in: self)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        performLayout(in: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        performLayout(in: self)
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
