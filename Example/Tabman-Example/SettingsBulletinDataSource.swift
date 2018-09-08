//
//  SettingsBulletinDataSource.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 21/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import BLTNBoard
import Pageboy

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
    
    static func makeSettingsPage(for pageViewController: PageboyViewController) -> SettingsBulletinPage {
        let page = SettingsBulletinPage(title: "Settings", pageViewController: pageViewController)
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
