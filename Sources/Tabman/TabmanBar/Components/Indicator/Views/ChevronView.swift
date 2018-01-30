//
//  ChevronView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal class ChevronView: UIView {
    
    private var chevronLayer = CAShapeLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.superview?.layoutIfNeeded()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: self.bounds.size.height))
        path.addLine(to: CGPoint(x: self.bounds.size.width / 2, y: 0.0))
        path.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.size.height))
        path.close()
        
        self.chevronLayer.frame = self.bounds
        self.chevronLayer.path = path.cgPath
        self.layer.mask = self.chevronLayer
    }
    
}
