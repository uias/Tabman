//
//  TabmanCircularView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

internal class TabmanCircularView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.superview?.layoutIfNeeded()
        self.layer.cornerRadius = self.bounds.size.width / 2.0
    }
}
