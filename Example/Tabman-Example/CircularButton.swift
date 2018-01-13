//
//  CircularButton.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 27/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

@IBDesignable class CircularButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) { 
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 1.15, y: 1.15) : .identity
            }
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            layer.borderColor = tintColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initButton()
    }
    
    private func initButton() {
        self.layer.borderColor = tintColor.cgColor
        self.layer.borderWidth = 1.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.superview?.layoutIfNeeded()
        self.layer.cornerRadius = self.bounds.size.width / 2.0
    }
}
