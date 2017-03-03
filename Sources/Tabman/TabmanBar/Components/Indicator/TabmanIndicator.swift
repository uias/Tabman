//
//  TabmanIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 03/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

public class TabmanIndicator: UIView {
    
    //
    // MARK: Types
    //
    
    public enum Style {
        case none
        case line
        case custom(type: TabmanIndicator.Type)
    }
}
