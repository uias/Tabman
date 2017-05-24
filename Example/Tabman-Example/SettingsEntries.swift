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
        
        let styleOptions = [TabmanBar.Style.scrollingButtonBar.description,
                            TabmanBar.Style.buttonBar.description,
                            TabmanBar.Style.blockTabBar.description,
                            TabmanBar.Style.bar.description]
        
        let indicatorStyleOptions = ["Default",
                            TabmanIndicator.Style.line.description,
                            TabmanIndicator.Style.dot.description,
                            TabmanIndicator.Style.chevron.description,
                            TabmanIndicator.Style.clear.description]
        
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
        appearanceSection.add(item: SettingsItem(type: .options(values: styleOptions,
                                                                selectedValue: { return self.tabViewController?.bar.style.description }),
                                                 title: "Bar Style",
                                                 description: nil,
                                                 value: nil, update:
            { (value) in
                let style = TabmanBar.Style.fromDescription(value as! String)
                self.tabViewController?.bar.style = style
                self.tabViewController?.bar.appearance = PresetAppearanceConfigs.forStyle(style,
                                                                                           currentAppearance: self.tabViewController?.bar.appearance)
                self.tabViewController?.reloadPages()
        }))
        appearanceSection.add(item: SettingsItem(type: .options(values: indicatorStyleOptions,
                                                                selectedValue: { return self.tabViewController?.bar.appearance?.indicator.preferredStyle?.description ?? "Default" }),
                                                 title: "Preferred Indicator Style",
                                                 description: nil,
                                                 value: nil, update:
            { (value) in
                guard let description = value as? String else { return }
                let style = TabmanIndicator.Style.fromDescription(description)
                
                let appearance = self.tabViewController?.bar.appearance
                appearance?.indicator.preferredStyle = style
                self.tabViewController?.bar.appearance = appearance
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
        appearanceSection.add(item: SettingsItem(type: .toggle,
                                                 title: "Compressing Indicator",
                                                 description: "Whether the indicator should compress at the end of page ranges.",
                                                 value: self.tabViewController?.bar.appearance?.indicator.compresses,
                                                 update:
            { (value) in
                let appearance = self.tabViewController?.bar.appearance
                appearance?.indicator.compresses = value as? Bool
                self.tabViewController?.bar.appearance = appearance
        }))
        
        sections.append(appearanceSection)
        sections.append(pageVCSection)
        
        return sections
    }

}

fileprivate extension TabmanBar.Style {
    
    var description: String {
        switch self {
        case .bar:
            return "Bar"
        case .buttonBar:
            return "Button Bar"
        case .scrollingButtonBar:
            return "Scrolling Button Bar"
        case .blockTabBar:
            return "Block Tab Bar"
            
        default:
            return "Custom"
        }
    }
    
    static func fromDescription(_ description: String) -> TabmanBar.Style {
        switch description {
            
        case "Scrolling Button Bar":
            return .scrollingButtonBar
        case "Button Bar":
            return .buttonBar    
        case "Block Tab Bar":
            return .blockTabBar
            
        default:
            return .bar
        }
    }
}

fileprivate extension TabmanIndicator.Style {
    
    var description: String {
        switch self {
        case .line:
            return "Line"
        case .dot:
            return "Dot"
        case .chevron:
            return "Chevron"
        case .clear:
            return "Clear"
            
        default:
            return "Custom"
        }
    }
    
    static func fromDescription(_ description: String) -> TabmanIndicator.Style? {
        switch description {
        case "Clear":
            return .clear
        case "Line":
            return .line
        case "Dot":
            return .dot
        case "Chevron":
            return .chevron

        default:
            return nil
        }
    }
}
