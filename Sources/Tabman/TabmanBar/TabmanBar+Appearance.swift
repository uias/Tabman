//
//  TabmanBarStyle.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

public extension TabmanBar {
    
    /// Appearance configuration for a TabmanBar.
    public class Appearance: Any {
        
        // MARK: Properties
        
        /// The indicator configuration.
        public lazy var indicator = Indicator()
        /// The state configuration.
        public lazy var state = State()
        /// Text display configuration.
        public lazy var text = Text()
        /// Layout configuration.
        public lazy var layout = Layout()
        /// Bar style configuration.
        public lazy var style = Style()
        /// Bar interaction configuration
        public lazy var interaction = Interaction()
        
        // MARK: Init

        public init(_ appearance: (Appearance) -> ()) {
            self.setDefaultValues()
            appearance(self)
        }
        
        static public var defaultAppearance: Appearance {
            let config = Appearance({ _ in })
            config.setDefaultValues()
            return config
        }
        
        private func setDefaultValues() {
            
            // indicator
            self.indicator.bounces = false
            self.indicator.compresses = false
            self.indicator.isProgressive = false
            self.indicator.useRoundedCorners = false
            self.indicator.lineWeight = .normal
            self.indicator.color = UIView.defaultTintColor
            
            // state
            self.state.selectedColor = .black
            self.state.color = UIColor.black.withAlphaComponent(0.5)
            
            // text
            self.text.font = UIFont.systemFont(ofSize: 16.0)
            
            // layout
            self.layout.height = .auto
            self.layout.interItemSpacing = 20.0
            self.layout.edgeInset = 16.0
            self.layout.itemVerticalPadding = 12.0
            self.layout.itemDistribution = .leftAligned
            
            // style
            self.style.background = .blur(style: .extraLight)
            self.style.bottomSeparatorColor = .clear
            
            // interaction
            self.interaction.isScrollEnabled = true
        }
    }
}

/// Appearance updating
public protocol TabmanAppearanceUpdateable {
    
    /// Update the appearance of the tab bar for a new configuration.
    ///
    /// - Parameter appearance: The new configuration.
    /// - Parameter default: The default appearance configuration.
    func update(forAppearance appearance: TabmanBar.Appearance, defaultAppearance: TabmanBar.Appearance)
}
