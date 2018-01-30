//
//  CircularView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal class CircularView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.superview?.layoutIfNeeded()
        self.layer.cornerRadius = self.bounds.size.width / 2.0
    }
}
