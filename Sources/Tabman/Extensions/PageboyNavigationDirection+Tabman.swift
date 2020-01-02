//
//  PageboyNavigationDirection+Tabman.swift
//  Tabman
//
//  Created by Merrick Sapsford on 02/01/2020.
//  Copyright © 2020 UI At Six. All rights reserved.
//

import Pageboy

extension PageboyViewController.NavigationDirection {
    
    var barUpdateDirection: TMBarUpdateDirection {
        switch self {
        case .forward:
            return .forward
        case .neutral:
            return .none
        case .reverse:
            return .reverse
        }
    }
}
