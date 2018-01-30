//
//  TabmanIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 03/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// The lifecycle for an indicator.
public protocol TabmanIndicatorLifecycle {
    
    /// Construct the indicator
    func constructIndicator()
}

internal protocol TabmanIndicatorDelegate: class {
    
    func indicator(requiresLayoutInvalidation indicator: TabmanIndicator)
}

/// Indicator that highlights the currently visible page.
open class TabmanIndicator: UIView, TabmanIndicatorLifecycle {
    
    //
    // MARK: Types
    //
    
    /// The style of indicator to display.
    ///
    /// - clear: No visible indicator.
    /// - line: Horizontal line pinned to bottom of bar.
    /// - dot: Circular centered dot pinned to the bottom of the bar.
    /// - chevron: Centered chevron pinned to the bottom of the bar.
    /// - custom: A custom defined indicator.
    public enum Style {
        case clear
        case line
        case dot
        case chevron
        case custom(type: TabmanIndicator.Type)
    }
    
    /// The layer (Z) position of the indicator in relation to the bar contents.
    ///
    /// - background: Behind bar contents.
    /// - foreground: In front of bar contents.
    internal enum LayerPosition {
        case background
        case foreground
    }
    
    //
    // MARK: Properties
    //
    
    weak var delegate: TabmanIndicatorDelegate?
    
    /// Whether the indicator can support a progressive style.
    public private(set) var isProgressiveCapable: Bool = true
    
    //
    // MARK: Init
    //
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initIndicator()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initIndicator()
    }
    
    private func initIndicator() {
        self.constructIndicator()
    }
    
    //
    // MARK: Lifecycle
    //
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        let layerPosition = self.preferredLayerPosition()
        switch layerPosition {
        case .background:
            self.superview?.sendSubview(toBack: self)
        default:
            self.superview?.bringSubview(toFront: self)
        }
    }
    
    open func constructIndicator() {
        fatalError("constructIndicator() should be implemented in TabmanBar subclasses.")
    }
    
    /// The preferred layer position for the indicator.
    ///
    /// - Returns: Preferred layer position.
    internal func preferredLayerPosition() -> LayerPosition {
        return .foreground
    }
    
    /// The type of item transition to use with this indicator. (Internal use only)
    ///
    /// - Returns: The item transition type.
    internal func itemTransitionType() -> TabmanItemTransition.Type? {
        return TabmanItemColorCrossfadeTransition.self
    }
}

internal extension TabmanIndicator.Style {
    
    static func fromType(_ type: TabmanIndicator.Type?) -> TabmanIndicator.Style {
        guard let type = type else {
            return .clear
        }
        
        switch type {
        case is TabmanLineIndicator.Type:
            return .line
            
        case is TabmanDotIndicator.Type:
            return .dot
            
        default:
            return .custom(type: type)
        }
    }
}
