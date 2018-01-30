//
//  TabmanBarStyle.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public extension TabmanBar {
    
    /// Appearance configuration for a TabmanBar.
    public class Appearance: Any {
        
        public struct Indicator {
            /// The preferred style to use for the indicator.
            /// This is optionally conformed to by the bar.
            public var preferredStyle: TabmanIndicator.Style?
            /// The color of the bar indicator.
            public var color: UIColor?
            /// The weight (thickness) of the bar indicator if using a line indicator.
            public var lineWeight: TabmanIndicator.LineWeight?
            /// Whether the indicator transiton is progressive.
            public var isProgressive: Bool?
            /// Whether the indicator bounces at the end of page ranges.
            public var bounces: Bool?
            /// Whether the indicator compresses at the end of page ranges (Unavailable if bounces enabled).
            public var compresses: Bool?
            /// Whether to use rounded corners on line indicators.
            public var useRoundedCorners: Bool?
        }
        
        public struct Interaction {
            /// Whether user scroll is enabled on a scrolling button bar.
            public var isScrollEnabled: Bool?
        }
        
        public struct Layout {
            
            /// The distribution of items within a TabmanBar.
            ///
            /// - leftAligned: Items will be laid out from the left of the bar.
            /// - centered: Items will be laid out from the center of the bar.
            public enum ItemDistribution {
                case leftAligned
                case centered
            }
            
            /// The spacing between items in the bar.
            public var interItemSpacing: CGFloat?
            /// The spacing at the edge of the items in the bar.
            public var edgeInset: CGFloat?
            /// Edge insets for the bottom separator relative to the bar.
            public var bottomSeparatorEdgeInsets: UIEdgeInsets?
            /// The height for the bar.
            public var height: TabmanBar.Height?
            /// The vertical padding between the item and the bar bounds.
            public var itemVerticalPadding: CGFloat?
            /// How items in the bar should be distributed.
            public var itemDistribution: ItemDistribution?
            /// The minimum width for item
            public var minimumItemWidth: CGFloat?
            /// Whether to extend the background edge insets in certain scenarios.
            /// For example when the bar is against the status bar, the background 
            /// will extend underneath the status bar.
            public var extendBackgroundEdgeInsets: Bool?
        }
        
        public struct State {
            /// The color to use for selected items in the bar (text/images etc.).
            public var selectedColor: UIColor?
            /// The text color to use for unselected items in the bar (text/images etc.).
            public var color: UIColor?
            /// Whether to hide bar when there is only a single item
            public var shouldHideWhenSingleItem: Bool?
        }
        
        public struct Style {
            /// The background style for the bar.
            public var background: TabmanBar.BackgroundView.Style?
            /// Whether to show a fade on the items at the bounds edge of a scrolling button bar.
            public var showEdgeFade: Bool?
            /// Color of the separator at the bottom of the bar.
            public var bottomSeparatorColor: UIColor?
            /// The image rendering mode for items that have an image
            public var imageRenderingMode: UIImageRenderingMode?
        }
        
        public struct Text {
            /// The font to use for text labels in the bar.
            public var font: UIFont?
        }
        
        // MARK: Properties
        
        /// The indicator configuration.
        public var indicator = Indicator()
        /// The state configuration.
        public var state = State()
        /// Text display configuration.
        public var text = Text()
        /// Layout configuration.
        public var layout = Layout()
        /// Bar style configuration.
        public var style = Style()
        /// Bar interaction configuration
        public var interaction = Interaction()
        
        // MARK: Init

        public init(_ appearance: (Appearance) -> Void) {
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
            self.state.shouldHideWhenSingleItem = false
            
            // text
            self.text.font = UIFont.systemFont(ofSize: 16.0)
            
            // layout
            self.layout.height = .auto
            self.layout.interItemSpacing = 20.0
            self.layout.edgeInset = 16.0
            self.layout.bottomSeparatorEdgeInsets = .zero
            self.layout.itemVerticalPadding = 12.0
            self.layout.itemDistribution = .leftAligned
            self.layout.minimumItemWidth = 44.0
            self.layout.extendBackgroundEdgeInsets = true
            
            // style
            self.style.background = .blur(style: .extraLight)
            self.style.bottomSeparatorColor = .clear
            self.style.imageRenderingMode = .alwaysTemplate
          
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
