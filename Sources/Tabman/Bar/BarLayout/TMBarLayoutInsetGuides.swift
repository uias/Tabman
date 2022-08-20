//
//  TMBarLayoutInsetGuides.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/08/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

/// Object that provides layout guides for bar layout insets.
internal protocol TMBarLayoutInsetGuides: AnyObject {
    
    /// The leading inset guide for the layout.
    var leadingInset: UILayoutGuide { get }
    /// The trailing inset guide for the layout.
    var trailingInset: UILayoutGuide { get }
    /// The insetted guide for the content in the layout.
    var content: UILayoutGuide { get }
    
    /// The insets that are applied to the layout.
    var insets: UIEdgeInsets { get set }
}
