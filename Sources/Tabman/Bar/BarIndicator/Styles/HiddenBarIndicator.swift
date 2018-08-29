
//
//  HiddenBarIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 29/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public final class HiddenBarIndicator: BarIndicator {
    
    // MARK: Properties
    
    public override var displayStyle: BarIndicator.DisplayStyle {
        return .fill
    }
    
    public override var backgroundColor: UIColor? {
        set {
            super.backgroundColor = .clear
        } get {
            return super.backgroundColor
        }
    }
    
    // MARK: Lifecycle
    
//    public override func performLayout(in view: UIView) {
//        super.performLayout(in: view)
//
//        NSLayoutConstraint.activate([
//            view.heightAnchor.constraint(equalToConstant: 0.0)
//            ])
//    }
}
