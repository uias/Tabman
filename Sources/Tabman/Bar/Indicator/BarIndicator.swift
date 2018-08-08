//
//  BarIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 07/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

open class BarIndicator: UIView {
    
    // MARK: Types
    
    public enum DisplayStyle {
        case header
        case fill
        case footer
    }
    
    // MARK: Properties
    
    open var displayStyle: DisplayStyle {
        fatalError("Return displayStyle in subclass")
    }
    
    // MARK: Init
    
    public required init() {
        super.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
