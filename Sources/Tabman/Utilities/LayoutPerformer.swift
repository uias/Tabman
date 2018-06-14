//
//  LayoutPerformer.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public protocol LayoutPerformer {
    
    var hasPerformedLayout: Bool { get }
    
    func performLayout(in view: UIView)
}
