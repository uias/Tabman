//
//  BarLayoutParent.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal protocol BarLayoutParent: class {
    
    var contentInset: UIEdgeInsets { get set }
    
    var isPagingEnabled: Bool { get set }
}
