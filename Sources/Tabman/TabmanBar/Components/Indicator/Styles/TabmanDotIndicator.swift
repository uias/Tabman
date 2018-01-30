//
//  TabmanDotIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal class TabmanDotIndicator: TabmanIndicator {
    
    //
    // MARK: Properties
    //
    
    private var dotView = CircularView()
    
    /// The color of the dot.
    override public var tintColor: UIColor! {
        didSet {
            self.dotView.backgroundColor = tintColor
        }
    }
    
    public override var isProgressiveCapable: Bool {
        return false
    }
    
    //
    // MARK: Lifecycle
    //
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 6.0)
    }
    
    public override func constructIndicator() {
        
        self.addSubview(dotView)
        dotView.set(.height, to: intrinsicContentSize.height)
        dotView.set(.width, to: intrinsicContentSize.height)
        dotView.alignToSuperviewAxis(.vertical)
        dotView.pinToSuperviewEdge(.bottom, inset: 2.0)
        dotView.backgroundColor = self.tintColor
    }
    
    override func itemTransitionType() -> TabmanItemTransition.Type? {
        return TabmanItemColorCrossfadeTransition.self
    }
}
