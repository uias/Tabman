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
        appearance.style.background = .blur(style: .extraLight)
        
        switch style {

        case .bar:
            appearance.indicator.color = UIColor.black.withAlphaComponent(0.4)
            appearance.indicator.lineWeight = .thick
            
        case .scrollingButtonBar:
            appearance.state.color = UIColor.black.withAlphaComponent(0.2)
            appearance.state.selectedColor = UIColor.black.withAlphaComponent(0.5)
            appearance.indicator.color = UIColor.black.withAlphaComponent(0.4)
            appearance.layout.itemVerticalPadding = 16.0
            appearance.indicator.bounces = true
            appearance.indicator.lineWeight = .normal
            appearance.layout.edgeInset = 16.0
            appearance.layout.interItemSpacing = 20.0

        case .buttonBar:
            appearance.state.color = UIColor.black.withAlphaComponent(0.2)
            appearance.state.selectedColor = UIColor.black.withAlphaComponent(0.5)
            appearance.indicator.color = UIColor.black.withAlphaComponent(0.4)
            appearance.indicator.lineWeight = .thin
            appearance.indicator.compresses = true
            appearance.layout.edgeInset = 8.0
            appearance.layout.interItemSpacing = 0.0
            
        case .blockTabBar:
            appearance.state.color = UIColor.black.withAlphaComponent(0.2)
            appearance.state.selectedColor = UIColor.black.withAlphaComponent(0.5)
            appearance.indicator.color = UIColor.white
            appearance.layout.edgeInset = 0.0
            appearance.layout.interItemSpacing = 0.0
            appearance.indicator.bounces = true

        default:
            appearance.style.background = .blur(style: .light)
        }
        
        if #available(iOS 8.2, *) {
            appearance.text.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        }
        
        return appearance
    }
}
