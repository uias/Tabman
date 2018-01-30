//
//  TabmanBar+Config.swift
//  Tabman
//
//  Created by Merrick Sapsford on 24/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public extension TabmanBar {
    
    public class Config {
        
        // MARK: Properties
        
        internal weak var handler: TabmanBarConfigHandler?
        
        /// The style to use for the bar. Default = .scrollingButtonBar
        public var style: TabmanBar.Style = .scrollingButtonBar {
            didSet {
                guard style.rawType != oldValue.rawType else {
                    return
                }
                
                self.handler?.config(self, didUpdate: style)
            }
        }
        
        /// The location of the bar on screen. Default = .preferred
        public var location: Location = .preferred {
            didSet {
                guard location != oldValue else {
                    return
                }
                self.handler?.config(self, didUpdate: location)
            }
        }
        /// The actual location of the bar on screen (including preferred location).
        internal var actualLocation: Location {
            if location == .preferred {
                return style.preferredLocation
            }
            return location
        }
        
        /// The items to display in the bar.
        public var items: [TabmanBar.Item]? {
            didSet {
                self.handler?.config(self, didUpdate: items)
            }
        }
        
        /// The appearance configuration of the bar.
        public var appearance: TabmanBar.Appearance? {
            didSet {
                self.handler?.config(self, didUpdate: appearance ?? .defaultAppearance)
            }
        }
        
        /// The content inset required for content underneath the bar.
        @available(*, deprecated: 0.5.0, message: "Use requiredInsets")
        public var requiredContentInset: UIEdgeInsets {
            return requiredInsets.barInsets
        }
        
        /// The required insets for the bar.
        public internal(set) var requiredInsets: TabmanBar.Insets = .zero
        
        /// Collection of behaviors that are active on the bar.
        public var behaviors: [Behavior]? {
            didSet {
                handler?.config(self, didUpdate: behaviors)
            }
        }
        
        /// Object that acts as a delegate to the current TabmanBar.
        public weak var delegate: TabmanBarDelegate?
    }
}
