//
//  TabmanBarConfig.swift
//  Tabman
//
//  Created by Merrick Sapsford on 24/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

internal protocol TabmanBarConfigDelegate {
    
    func config(_ config: TabmanBarConfig, didUpdateStyle style: TabmanBarConfig.Style)
    
    func config(_ config: TabmanBarConfig, didUpdateLocation location: TabmanBarConfig.Location)
    
    func config(_ config: TabmanBarConfig, didUpdateItems items: [TabmanBarItem]?)
    
    func config(_ config: TabmanBarConfig, didUpdateAppearance appearance: TabmanBar.AppearanceConfig)
}

public class TabmanBarConfig: Any {
    
    //
    // MARK: Types
    //
    
    public enum Style {
        case buttonBar
        case progressiveBar
        case segmented
    }
    
    public enum Location {
        case top
        case bottom
    }

    //
    // MARK: Properties
    //
    
    internal var delegate: TabmanBarConfigDelegate?
    
    
    /// The style to use for the bar. Default = .buttonBar
    public var style: Style = .buttonBar {
        didSet {
            guard style != oldValue else { return }
            
            self.delegate?.config(self, didUpdateStyle: style)
        }
    }
    
    /// The location of the bar on screen. Default = .top
    public var location: Location = .top {
        didSet {
            guard location != oldValue else {
                return
            }
            self.delegate?.config(self, didUpdateLocation: location)
        }
    }
    
    /// The items to display in the bar.
    public var items: [TabmanBarItem]? {
        didSet {
            self.delegate?.config(self, didUpdateItems: items)
        }
    }
    
    /// The appearance configuration of the bar.
    public var appearance: TabmanBar.AppearanceConfig? {
        didSet {
            self.delegate?.config(self, didUpdateAppearance: appearance ?? .defaultAppearance)
        }
    }
    
}
