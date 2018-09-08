//
//  TabPageViewController+Settings.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 19/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import BLTNBoard

extension TabPageViewController {
    
    // MARK: Actions
    
    @IBAction private func settingsButtonPressed(_ sender: UIButton) {
        showBulletin(makeSettingsBulletinManager())
    }
}
