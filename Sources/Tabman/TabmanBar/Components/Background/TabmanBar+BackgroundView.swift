//
//  TabmanBar+BackgroundView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

// swiftlint:disable nesting

import UIKit

public extension TabmanBar {
 
    /// View that displays background styles for a TabmanBar.
    public class BackgroundView: UIView {
        
        //
        // MARK: Types
        //
        
        public enum Style {
            case clear
            case blur(style: UIBlurEffect.Style)
            case solid(color: UIColor)
        }
        
        //
        // MARK: Properties
        //
        
        var style: Style = TabmanBar.Appearance.defaultAppearance.style.background ?? .clear {
            didSet {
                self.updateBackground(for: style)
            }
        }
        
        private var backgroundContainer = UIView()
        
        //
        // MARK: Init
        //
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            configure()
        }
        
        private func configure() {
            self.addSubview(self.backgroundContainer)
            self.backgroundContainer.pinToSuperviewEdges()
            
            self.updateBackground(for: style)
        }
        
        //
        // MARK: Lifecycle
        //
        
        func updateBackground(for style: Style) {
            self.backgroundContainer.removeAllSubviews()
            
            switch style {
                
            case .blur(let style):
                let blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
                self.backgroundContainer.addSubview(blurView)
                blurView.pinToSuperviewEdges()
                
            case .solid(let color):
                let colorView = UIView()
                colorView.backgroundColor = color
                self.backgroundContainer.addSubview(colorView)
                colorView.pinToSuperviewEdges()
                
            default:()
            }
        }
    }
}

extension TabmanBar.BackgroundView.Style: CustomStringConvertible, Equatable {
    
    public var description: String {
        switch self {
        case .blur(let style):
            return "blur\(style.rawValue)"
            
        case .solid(let color):
            return "color\(color.hashValue)"
            
        default:
            return "none"
        }
    }
    
    public static func == (lhs: TabmanBar.BackgroundView.Style,
                           rhs: TabmanBar.BackgroundView.Style) -> Bool {
        return lhs.description == rhs.description
    }
}
