//
//  BarLayoutContainer.swift
//  Tabman
//
//  Created by Merrick Sapsford on 29/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

open class BarLayoutContainer: UIView {
    
    // MARK: Init
    
    public required init() {
        super.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("BarLayoutContainer does not support storyboards.")
    }
}
