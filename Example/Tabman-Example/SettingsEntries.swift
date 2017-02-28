//
//  SettingsEntries.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 28/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

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
        
        let barSection = SettingsSection(title: "Bar")
        barSection.add(item: SettingsItem(type: .toggle,
                                          title: "Scroll Enabled",
                                          description: "Whether user scroll is enabled on the bar.",
                                          value: self.tabViewController?.bar.appearance?.isScrollEnabled,
                                          update:
            { (value) in
                let appearance = self.tabViewController?.bar.appearance
                appearance?.isScrollEnabled = value as? Bool
                self.tabViewController?.bar.appearance = appearance
        }))
        
        sections.append(barSection)
        sections.append(pageVCSection)
        
        return sections
    }

}

