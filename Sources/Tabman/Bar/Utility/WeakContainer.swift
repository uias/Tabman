//
//  WeakContainer.swift
//  Tabman
//
//  Created by Merrick Sapsford on 03/07/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import Foundation

internal class WeakContainer<T: AnyObject> {
    
    // MARK: Properties
    
    private(set) weak var object: T?
    
    // MARK: Init
    
    init(for object: T) {
        self.object = object
    }
}
