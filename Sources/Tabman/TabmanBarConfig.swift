//
//  TabmanBarConfig.swift
//  Tabman
//
//  Created by Merrick Sapsford on 24/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

/// Update handler protocol for TabmanBarConfig updates.
internal protocol TabmanBarConfigDelegate: class {
    
    /// The config had its style updated.
    ///
    /// - Parameters:
    ///   - config: The config.
    ///   - style: The new style.
    func config(_ config: TabmanBarConfig, didUpdate style: TabmanBar.Style)
    
    /// The config had its location updated.
    ///
    /// - Parameters:
    ///   - config: The config.
    ///   - location: The new location.
    func config(_ config: TabmanBarConfig, didUpdate location: TabmanBarConfig.Location)
    
    /// The config had its items updated.
    ///
    /// - Parameters:
    ///   - config: The config.
    ///   - items: The new items.
    func config(_ config: TabmanBarConfig, didUpdate items: [TabmanBarItem]?)
    
    /// The config had its appearance config updated.
    ///
    /// - Parameters:
    ///   - config: The config.
    ///   - appearance: The new appearance config.
    func config(_ config: TabmanBarConfig, didUpdate appearance: TabmanBar.Appearance)
}

/// Configuration object for adjusting appearance and contents of a TabmanBar.
public class TabmanBarConfig: Any {
    
    //
    // MARK: Types
    //
    
    /// The location of the bar on screen.
    ///
    /// - perferred: Use the preferred location for the current style.
    /// - top: At the top. (Note: this will take account of UINavigationBar etc.)
    /// - bottom: At the bottom. (Note: this will take account of UITabBar etc.)
    public enum Location {
        case preferred
        case top
        case bottom
    }

    //
    // MARK: Properties
    //
    
    internal weak var delegate: TabmanBarConfigDelegate?
    
    
    /// The style to use for the bar. Default = .scrollingButtonBar
    public var style: TabmanBar.Style = .scrollingButtonBar {
        didSet {
            guard style.rawType != oldValue.rawType else { return }
            
            self.delegate?.config(self, didUpdate: style)
        }
    }
    
    /// The location of the bar on screen. Default = .preferred
    public var location: Location = .preferred {
        didSet {
            guard location != oldValue else {
                return
            }
            self.delegate?.config(self, didUpdate: location)
        }
    }
    
    /// The items to display in the bar.
    public var items: [TabmanBarItem]? {
        didSet {
            self.delegate?.config(self, didUpdate: items)
        }
    }
    
    /// The appearance configuration of the bar.
    public var appearance: TabmanBar.Appearance? {
        didSet {
            self.delegate?.config(self, didUpdate: appearance ?? .defaultAppearance)
        }
    }
    
    /// The content inset required for content underneath the bar.
    @available(*, deprecated: 0.5.0, message: "Use requiredInsets")
    public var requiredContentInset: UIEdgeInsets {
        return requiredInsets.barInsets
    }
    
    /// The required insets for the bar.
    public internal(set) var requiredInsets: TabmanBar.Insets = .zero
}

// MARK: - Additional Style properties for internal use
internal extension TabmanBar.Style {
    
    /// Where the bar is preferred to be displayed for the style.
    var preferredLocation: TabmanBarConfig.Location {
        switch self {
            
        case .bar:
            return .bottom
            
        default:
            return .top
        }
    }
}

// MARK: - TabmanBarConfig.Style Typing
internal extension TabmanBar.Style {
    
    var rawType: TabmanBar.Type? {
        switch self {
            
        case .bar:
            return TabmanLineBar.self
            
        case .buttonBar:
            return TabmanFixedButtonBar.self
            
        case .scrollingButtonBar:
            return TabmanScrollingButtonBar.self
            
        case .blockTabBar:
            return TabmanBlockTabBar.self
            
        case .custom(let type):
            return type
        }
    }
}
