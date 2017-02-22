//
//  TabmanBarStyle.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

public extension TabmanBar {
    
    public class AppearanceConfig: Any {
        
        //
        // MARK: Properties
        //
        
        // Indicator
        public var indicatorColor: UIColor?
        public var indicatorWeight: TabmanLineIndicator.Weight?
        
        // Text
        public var textFont: UIFont?
        public var selectedTextColor: UIColor?
        public var textColor: UIColor?
        
        // Background
        public var backgroundStyle: TabmanBarBackgroundView.BackgroundStyle?
        
        //
        // MARK: Init
        //
        
        public init(_ configurer: (AppearanceConfig) -> ()) {
            configurer(self)
        }
        
        static var defaultAppearance: AppearanceConfig {
            return AppearanceConfig({ (config) in
                // default config
            })
        }
    }
}
