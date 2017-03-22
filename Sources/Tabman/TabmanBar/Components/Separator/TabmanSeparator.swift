//
//  TabmanSeparator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

public class TabmanSeparator: UIView {
    
    //
    // MARK: Properties
    //
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 0.5)
    }
    
    public override var tintColor: UIColor! {
        didSet {
            self.color = tintColor
        }
    }
    /// The color of the separator.
    public var color: UIColor = .clear {
        didSet {
            self.backgroundColor = color
        }
    }
    
    //
    // MARK: Init
    //
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initSeparator()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSeparator()
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    private func initSeparator() {
        
        self.backgroundColor = self.color
    }
}
