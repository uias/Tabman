//
//  ActionButton.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 19/07/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

@IBDesignable class ActionButton: UIButton {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let backgroundColor = UIColor.white.withAlphaComponent(0.2)
        static let highlightedBackgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = self.isHighlighted ? Defaults.highlightedBackgroundColor : Defaults.backgroundColor
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 16.0
        backgroundColor = Defaults.backgroundColor
    }
}
