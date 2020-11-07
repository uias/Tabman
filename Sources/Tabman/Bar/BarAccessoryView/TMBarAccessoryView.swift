//
//  TMBarAccessoryView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 07/11/2020.
//  Copyright © 2020 UI At Six. All rights reserved.
//

import UIKit

/// View which can be used as an accessory in a bar.
public typealias TMBarAccessoryView = UIView

extension TMBarAccessoryView {
    
    internal enum Location: Int, CaseIterable {
        case leading
        case leadingPinned
        case trailing
        case trailingPinned
    }
}
