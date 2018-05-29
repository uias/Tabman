//
//  BarLayoutContainer+Styles.swift
//  Tabman
//
//  Created by Merrick Sapsford on 29/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

public extension BarLayoutContainer {
    
    public enum Style {
        case buttonBar
        case custom(type: BarLayoutContainer.Type)
    }
    
    static func from(style: Style) -> BarLayoutContainer {
        switch style {
        case .buttonBar:
            return ButtonBarLayoutContainer()
        case .custom(let type):
            return type.init()
        }
    }
}
