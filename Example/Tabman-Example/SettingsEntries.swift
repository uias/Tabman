//
//  SettingsEntries.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 28/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Tabman

extension SettingsViewController {
    
    func addItems() -> [SettingsSection] {
        var sections = [SettingsSection]()
        
        let pageVCSection = SettingsSection(title: "Page View Controller")
        pageVCSection.add(item: SettingsItem(type: .toggle,
                                             title: "Infinite Scrolling",
                                             description: "Whether the page view controller should infinitely scroll between page ranges.",
                                             value: self.tabViewController?.isInfiniteScrollEnabled,
                                             update:
            { (value) in
                self.tabViewController?.isInfiniteScrollEnabled = value as! Bool
        }))
        
        let appearanceSection = SettingsSection(title: "Appearance")
        appearanceSection.add(item: SettingsItem(type: .options(values: [TabmanBarConfig.Style.buttonBar.description,
                                                                         TabmanBarConfig.Style.bar.description,
                                                                         TabmanBarConfig.Style.blockTabBar.description],
                                                                selectedValue: { return self.tabViewController?.bar.style.description }),
                                                 title: "Bar Style",
                                                 description: nil,
                                                 value: nil, update:
            { (value) in
                let style = TabmanBarConfig.Style.fromDescription(value as! String)
                self.tabViewController?.bar.style = style
                self.tabViewController?.bar.appearance = PresetAppeareanceConfigs.forStyle(style,
                                                                                           currentAppearance: self.tabViewController?.bar.appearance)
        }))
        appearanceSection.add(item: SettingsItem(type: .toggle,
                                                 title: "Scroll Enabled",
                                                 description: "Whether user scroll is enabled on the bar.",
                                                value: self.tabViewController?.bar.appearance?.interaction.isScrollEnabled,
                                                update:
            { (value) in
                let appearance = self.tabViewController?.bar.appearance
                appearance?.interaction.isScrollEnabled = value as? Bool
                self.tabViewController?.bar.appearance = appearance
        }))
        appearanceSection.add(item: SettingsItem(type: .toggle,
                                                 title: "Edge Fade",
                                                 description: "Whether to fade bar items at the edges of the bar.",
                                                 value: self.tabViewController?.bar.appearance?.style.showEdgeFade,
                                            update:
            { (value) in
                let appearance = self.tabViewController?.bar.appearance
                appearance?.style.showEdgeFade = value as? Bool
                self.tabViewController?.bar.appearance = appearance
        }))
        appearanceSection.add(item: SettingsItem(type: .toggle,
                                                 title: "Progressive Indicator",
                                                 description: "Whether the indicator should transition in a progressive manner.",
                                                 value: self.tabViewController?.bar.appearance?.indicator.isProgressive,
                                                 update:
            { (value) in
                let appearance = self.tabViewController?.bar.appearance
                appearance?.indicator.isProgressive = value as? Bool
                self.tabViewController?.bar.appearance = appearance
        }))
        appearanceSection.add(item: SettingsItem(type: .toggle,
                                                 title: "Bouncing Indicator",
                                                 description: "Whether the indicator should bounce at the end of page ranges.",
                                                 value: self.tabViewController?.bar.appearance?.indicator.bounces,
                                                 update:
            { (value) in
                let appearance = self.tabViewController?.bar.appearance
                appearance?.indicator.bounces = value as? Bool
                self.tabViewController?.bar.appearance = appearance
        }))
        
        sections.append(appearanceSection)
        sections.append(pageVCSection)
        
        return sections
    }

}

fileprivate extension TabmanBarConfig.Style {
    
    static func fromDescription(_ description: String) -> TabmanBarConfig.Style {
        switch description {
            
        case "Button Bar":
            return .buttonBar    
        case "Block Tab Bar":
            return .blockTabBar
            
        default:
            return .bar
        }
    }
    
    var description: String {
        switch self {
        case .buttonBar:
            return "Button Bar"
        case .bar:
            return "Bar"
        case .blockTabBar:
            return "Block Tab Bar"
            
        default:
            return "Custom"
        }
    }
}
