//
//  SettingsCells.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 27/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

protocol SettingsToggleCellDelegate {
    
    func settingsToggleCell(_ cell: SettingsToggleCell, didUpdateValue value: Bool)
    
}

class SettingsToggleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var toggle: UISwitch!
    var delegate: SettingsToggleCellDelegate?
    
    @IBAction func toggleSwitched(_ sender: UISwitch) {
        self.delegate?.settingsToggleCell(self, didUpdateValue: sender.isOn)
    }
}

class SettingsOptionCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
}
