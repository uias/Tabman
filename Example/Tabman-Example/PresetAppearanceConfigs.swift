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
        
        var view: UIView? = UIView()
        let defaultTintColor = view!.tintColor
        view = nil
        
        switch style {

        case .bar:
            appearance.style.background = .solid(color: .black)
            appearance.indicator.color = .white
            appearance.indicator.lineWeight = .thick
            
        case .buttonBar, .scrollingButtonBar:
            appearance.state.color = UIColor.white.withAlphaComponent(0.6)
            appearance.state.selectedColor = UIColor.white
            appearance.style.background = .blur(style: .light)
            appearance.indicator.color = UIColor.white
            appearance.layout.itemVerticalPadding = 16.0
            appearance.indicator.lineWeight = .normal
            appearance.indicator.compresses = true

        case .blockTabBar:
            appearance.state.color = UIColor.white.withAlphaComponent(0.6)
            appearance.state.selectedColor = defaultTintColor
            appearance.style.background = .solid(color: UIColor.white.withAlphaComponent(0.3))
            appearance.indicator.color = UIColor.white.withAlphaComponent(0.8)
            
        default:
            appearance.style.background = .blur(style: .light)
        }
        
        return appearance
    }
}
