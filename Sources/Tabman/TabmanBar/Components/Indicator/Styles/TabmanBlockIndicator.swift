//
//  TabmanBlockIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 09/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

internal class TabmanBlockIndicator: TabmanIndicator {
    
    override var intrinsicContentSize: CGSize {
        self.superview?.layoutIfNeeded()
        return self.superview?.bounds.size ?? .zero
    }
    
    /// The color of the indicator.
    override public var tintColor: UIColor! {
        didSet {
            self.backgroundColor = tintColor
        }
    }
    
    // MARK: Lifecycle
    
    override func preferredLayerPosition() -> TabmanIndicator.LayerPosition {
        return .background
    }
    
    public override func constructIndicator() {
        super.constructIndicator()
        
        self.tintColor = TabmanBar.Appearance.defaultAppearance.indicator.color
    }
}
