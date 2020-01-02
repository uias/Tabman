//
//  AutoInsetSpec.swift
//  AutoInset
//
//  Created by Merrick Sapsford on 16/01/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// Specification for Auto Insetting values.
public protocol AutoInsetSpec {
    
    /// The insets that are required IN addition to UIKit components / safe area.
    var additionalRequiredInsets: UIEdgeInsets { get }
    
    /// All insets that are required INCLUDING UIKit components / safe area.
    var allRequiredInsets: UIEdgeInsets { get }
}
