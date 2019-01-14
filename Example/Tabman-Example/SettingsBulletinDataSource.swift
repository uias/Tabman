//
//  SettingsBulletinDataSource.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 21/07/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit
import BLTNBoard
import Tabman

enum SettingsBulletinDataSource {
 
    // MARK: Pages
    
    static func makeIntroPage() -> BLTNPageItem {
        let page = BLTNPageItem(title: "Tabman")
        page.descriptionText = "A powerful paging view controller with tab bar."
        page.image = #imageLiteral(resourceName: "ic_welcome_icon")
        page.actionButtonTitle = "Continue"
        page.isDismissable = false
        page.actionHandler = { item in
            item.manager?.dismissBulletin()
        }
        page.requiresCloseButton = false
        return page
    }
    
    static func makeSettingsPage(for tabViewController: TabmanViewController,
                                 barDataSource: TMBarDataSource) -> SettingsBulletinPage {
        let page = SettingsBulletinPage(title: "Settings",
                                        tabViewController: tabViewController,
                                        barDataSource: barDataSource)
        page.requiresCloseButton = false
        return page
    }
}

extension SettingsBulletinDataSource {
    
    static func makePageboyAppearance(tintColor: UIColor?) -> BLTNItemAppearance {
        let appearance = BLTNItemAppearance()
        if let tintColor = tintColor {
            appearance.actionButtonColor = tintColor
        }
        return appearance
    }
}
