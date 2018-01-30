//
//  TabmanChevronIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal class TabmanChevronIndicator: TabmanIndicator {
    
    // MARK: Properties
    
    private var chevronView = ChevronView()
    
    /// The color of the chevron.
    override public var tintColor: UIColor! {
        didSet {
            self.chevronView.backgroundColor = tintColor
        }
    }
    
    public override var isProgressiveCapable: Bool {
        return false
    }
    
    // MARK: Lifecycle
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 10.0)
    }
    
    public override func constructIndicator() {
        
        chevronView.backgroundColor = self.tintColor
        
        self.addSubview(chevronView)
        chevronView.set(.height, to: intrinsicContentSize.height - 2.0)
        chevronView.set(.width, to: intrinsicContentSize.height)
        chevronView.alignToSuperviewAxis(.vertical)
        chevronView.pinToSuperviewEdge(.bottom)
    }
    
    override func itemTransitionType() -> TabmanItemTransition.Type? {
        return TabmanItemColorCrossfadeTransition.self
    }
}
