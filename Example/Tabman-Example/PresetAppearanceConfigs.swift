//
//  PresetAppearanceConfigs.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 10/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Tabman

class PresetAppearanceConfigs: Any {
    
    static func forStyle(_ style: TabmanBar.Style, currentAppearance: TabmanBar.Appearance?) -> TabmanBar.Appearance? {
        let appearance = currentAppearance ?? TabmanBar.Appearance.defaultAppearance
        appearance.indicator.bounces = false
        appearance.indicator.compresses = false

        var view: UIView? = UIView()
        let defaultTintColor = view!.tintColor
        view = nil
        
        switch style {

        case .bar:
            appearance.style.background = .solid(color: .black)
            appearance.indicator.color = .white
            appearance.indicator.lineWeight = .thick
            
        case .scrollingButtonBar:
            appearance.state.color = UIColor.white.withAlphaComponent(0.6)
            appearance.state.selectedColor = UIColor.white
            appearance.style.background = .blur(style: .light)
            appearance.indicator.color = UIColor.white
            appearance.layout.itemVerticalPadding = 16.0
            appearance.indicator.bounces = true
            appearance.indicator.lineWeight = .normal
            appearance.layout.edgeInset = 16.0
            appearance.layout.interItemSpacing = 20.0

        case .buttonBar:
            appearance.state.color = UIColor.white.withAlphaComponent(0.6)
            appearance.state.selectedColor = UIColor.white
            appearance.style.background = .blur(style: .light)
            appearance.indicator.color = UIColor.white
            appearance.indicator.lineWeight = .thin
            appearance.indicator.compresses = true
            appearance.layout.edgeInset = 8.0
            appearance.layout.interItemSpacing = 0.0
            
        case .blockTabBar:
            appearance.state.color = UIColor.white.withAlphaComponent(0.6)
            appearance.state.selectedColor = defaultTintColor
            appearance.style.background = .solid(color: UIColor.white.withAlphaComponent(0.3))
            appearance.indicator.color = UIColor.white.withAlphaComponent(0.8)
            appearance.layout.edgeInset = 0.0
            appearance.layout.interItemSpacing = 0.0
            appearance.indicator.bounces = true

        default:
            appearance.style.background = .blur(style: .light)
        }
        
        return appearance
    }
}
