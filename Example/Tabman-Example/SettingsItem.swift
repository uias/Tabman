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
    }
    
    typealias ItemUpdateClosure = (_ value: Any) -> Void
    
    // MARK: Properties
    
    let type: CellType
    let title: String
    let description: String?
    let update: ItemUpdateClosure
    
    // MARK: Init
    
    init(type: CellType, title: String, description: String?, update: @escaping ItemUpdateClosure) {
        self.type = type
        self.title = title
        self.description = description
        self.update = update
    }
}

extension SettingsItem.CellType {
    
    var reuseIdentifier: String {
        switch self {
        case .toggle:
            return "SettingsToggleCell"
        }
    }
}
