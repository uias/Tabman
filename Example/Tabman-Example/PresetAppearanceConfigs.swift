//
//  PresetAppearanceConfigs.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 10/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation
import Tabman

class PresetAppearanceConfigs: Any {
    
    static func forStyle(_ style: TabmanBar.Style, currentAppearance: TabmanBar.Appearance?) -> TabmanBar.Appearance? {
        let appearance = currentAppearance ?? TabmanBar.Appearance.defaultAppearance
        appearance.indicator.bounces = false
        appearance.indicator.compresses = false
        appearance.style.background = .blur(style: .dark)
        
        appearance.state.color = UIColor.white.withAlphaComponent(0.4)
        appearance.state.selectedColor = UIColor.white.withAlphaComponent(0.8)
        appearance.indicator.color = UIColor.white.withAlphaComponent(0.8)
        
        switch style {

        case .bar:
            appearance.indicator.lineWeight = .thick
            
        case .scrollingButtonBar:
            appearance.layout.itemVerticalPadding = 16.0
            appearance.indicator.bounces = true
            appearance.indicator.lineWeight = .normal
            appearance.layout.edgeInset = 16.0
            appearance.layout.interItemSpacing = 20.0
            appearance.style.showEdgeFade = true

        case .buttonBar:
            appearance.indicator.lineWeight = .thin
            appearance.indicator.compresses = true
            appearance.layout.edgeInset = 8.0
            appearance.layout.interItemSpacing = 0.0
            
        case .blockTabBar:
            appearance.indicator.color = UIColor.white.withAlphaComponent(0.3)
            appearance.layout.edgeInset = 0.0
            appearance.layout.interItemSpacing = 0.0
            appearance.indicator.bounces = true

        default:
            appearance.style.background = .blur(style: .light)
        }
        
        appearance.text.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        appearance.text.selectedFont = UIFont.systemFont(ofSize: 16.0, weight: .heavy)
        
        return appearance
    }
}
