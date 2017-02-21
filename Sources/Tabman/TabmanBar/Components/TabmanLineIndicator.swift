//
//  TabmanLineIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 20/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class TabmanLineIndicator: UIView {
    
    //
    // MARK: Properties
    //
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 2.0)
    }
    
    override var tintColor: UIColor! {
        didSet {
            self.backgroundColor = tintColor
        }
    }
    
    //
    // MARK: Init
    //
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initIndicator()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initIndicator()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    func initIndicator() {
        self.backgroundColor = self.tintColor
    }
}
