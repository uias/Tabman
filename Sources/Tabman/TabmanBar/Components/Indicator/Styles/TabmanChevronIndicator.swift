//
//  TabmanChevronIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout

internal class TabmanChevronIndicator: TabmanIndicator {
    
    //
    // MARK: Properties
    //
    
    private var chevronView = TabmanChevronView()
    
    /// The color of the chevron.
    override public var tintColor: UIColor! {
        didSet {
            self.chevronView.backgroundColor = tintColor
        }
    }
    
    public override var isProgressiveCapable: Bool {
        return false
    }
    
    //
    // MARK: Lifecycle
    //
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 10.0)
    }
    
    public override func constructIndicator() {
        
        chevronView.backgroundColor = self.tintColor
        
        self.addSubview(chevronView)
        chevronView.autoSetDimension(.height, toSize: self.intrinsicContentSize.height - 2.0)
        chevronView.autoSetDimension(.width, toSize: self.intrinsicContentSize.height)
        chevronView.autoAlignAxis(toSuperviewAxis: .vertical)
        chevronView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    override func itemTransitionType() -> TabmanItemTransition.Type? {
        return TabmanItemColorCrossfadeTransition.self
    }
}
