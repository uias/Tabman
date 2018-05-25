//
//  TabmanBarStyle.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

// swiftlint:disable nesting

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
        
        public struct Separator {
            /// Edge insets for the bottom separator relative to the bar.
            public var edgeInsets: UIEdgeInsets?
            /// The height of the separator at the bottom of the bar.
            public var height: SeparatorHeight?
            /// Color of the separator at the bottom of the bar.
            public var color: UIColor?
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
            /// - fill: Only applicable to scrolling button bar. Items will be padded with extra inter-item spacing if laying them out normally doesn't fill the entire width of the bar.
            public enum ItemDistribution {
                case leftAligned
                case centered
                case fill
            }
            
            /// The spacing between items in the bar.
            public var interItemSpacing: CGFloat?
            /// The spacing at the edge of the items in the bar.
            public var edgeInset: CGFloat?
            /// Edge insets for the bottom separator relative to the bar.
            @available(*, deprecated: 1.7.0, message: "Use appearance.bottomSeparator.edgeInsets")
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
            @available(*, deprecated: 1.7.0, message: "Use Behavior.AutoHiding instead")
            public var shouldHideWhenSingleItem: Bool?
        }
        
        public struct Style {
            /// The background style for the bar.
            public var background: TabmanBar.BackgroundView.Style?
            /// Whether to show a fade on the items at the bounds edge of a scrolling button bar.
            public var showEdgeFade: Bool?
            /// Color of the separator at the bottom of the bar.
            @available(*, deprecated: 1.7.0, message: "Use appearance.bottomSeparator.color")
            public var bottomSeparatorColor: UIColor?
            /// The image rendering mode for items that have an image
            public var imageRenderingMode: UIImageRenderingMode?
        }
        
        public struct Text {
            /// The font to use for text labels in the bar.
            public var font: UIFont?
            /// The selected font to use for text labels in the bar.
            public var selectedFont: UIFont?
        }
        
        // MARK: Properties
        
        /// The indicator configuration.
        public var indicator = Indicator()
        /// Bottom separator configuration.
        public var bottomSeparator = Separator()
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
            indicator.bounces = false
            indicator.compresses = false
            indicator.isProgressive = false
            indicator.useRoundedCorners = false
            indicator.lineWeight = .normal
            indicator.color = UIView.defaultTintColor
            
            // bottom separator
            bottomSeparator.edgeInsets = .zero
            bottomSeparator.height = .default
            bottomSeparator.color = .clear
            
            // state
            state.selectedColor = .black
            state.color = UIColor.black.withAlphaComponent(0.5)
            state.shouldHideWhenSingleItem = false
            
            // text
            text.font = UIFont.systemFont(ofSize: 16.0)

            // layout
            layout.height = .auto
            layout.interItemSpacing = 20.0
            layout.edgeInset = 16.0
            layout.itemVerticalPadding = 12.0
            layout.itemDistribution = .leftAligned
            layout.minimumItemWidth = 44.0
            layout.extendBackgroundEdgeInsets = true
            
            // style
            style.background = .blur(style: .extraLight)
            style.imageRenderingMode = .alwaysTemplate
          
            // interaction
            interaction.isScrollEnabled = true
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
