//
//  TabmanDotIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout

internal class TabmanDotIndicator: TabmanIndicator {
    
    //
    // MARK: Properties
    //
    
    private lazy var dotView: TabmanCircularView = {
        let dotView = TabmanCircularView()
        dotView.backgroundColor = self.tintColor
        return dotView
    }()
    
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
        dotView.autoSetDimension(.height, toSize: self.intrinsicContentSize.height)
        dotView.autoSetDimension(.width, toSize: self.intrinsicContentSize.height)
        dotView.autoAlignAxis(toSuperviewAxis: .vertical)
        dotView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 2.0)
    }
    
    override func itemTransitionType() -> TabmanItemTransition.Type? {
        return TabmanItemColorCrossfadeTransition.self
    }
}
