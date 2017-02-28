//
//  SettingsItem.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 27/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class SettingsItem: Any {
    
    // MARK: Types
    
    enum CellType {
        case toggle
        case options
    }
    
    typealias ItemUpdateClosure = (_ value: Any) -> Void
    
    // MARK: Properties
    
    let type: CellType
    let title: String
    let description: String?
    let update: ItemUpdateClosure
    var value: Any?
    
    // MARK: Init
    
    init(type: CellType,
         title: String,
         description: String?,
         value: Any?,
         update: @escaping ItemUpdateClosure) {
        
        self.type = type
        self.title = title
        self.description = description
        self.value = value
        self.update = update
    }
}

extension SettingsItem.CellType {
    
    var reuseIdentifier: String {
        switch self {
        case .toggle:
            return "SettingsToggleCell"
        case .options:
            return "SettingsOptionCell"
        }
    }
}

extension SettingsItem: SettingsToggleCellDelegate {
    
    func settingsToggleCell(_ cell: SettingsToggleCell, didUpdateValue value: Bool) {
        self.value = value
        update(value)
    }
}
