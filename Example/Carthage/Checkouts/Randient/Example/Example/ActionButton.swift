//
//  ActionButton.swift
//  Example
//
//  Created by Merrick Sapsford on 09/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let backgroundColor = UIColor.white.withAlphaComponent(0.4)
        static let highlightedBackgroundColor = UIColor.white.withAlphaComponent(0.7)
    }
    
    override var isHighlighted: Bool {
        didSet {
//            UIView.animate(withDuration: 0.2) {
//                self.backgroundColor = self.isHighlighted ? Defaults.highlightedBackgroundColor : Defaults.backgroundColor
//            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 16.0
        backgroundColor = Defaults.backgroundColor
    }
}

extension ActionButton: Themeable {
    
    func applyTheme(_ theme: Theme) {
        
        switch theme {
        case .light:
            backgroundColor = UIColor.white.withAlphaComponent(0.4)
            setTitleColor(.black, for: .normal)
        case .dark:
            backgroundColor = UIColor.black.withAlphaComponent(0.4)
            setTitleColor(.white, for: .normal)
        }
    }
}
