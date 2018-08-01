//
//  BarViewBackground.swift
//  Tabman
//
//  Created by Merrick Sapsford on 31/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public enum BarViewBackground {
    case none
    case flat(color: UIColor)
    case blur(style: UIBlurEffect.Style)
    case custom(view: UIView)
}

internal extension BarViewBackground {
    
    var backgroundView: UIView? {
        switch self {
        case .none:
            return nil
        case .custom(let view):
            return view
        default:
            return BarViewBackgroundView(for: self)
        }
    }
}
