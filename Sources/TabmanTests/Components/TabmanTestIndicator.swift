//
//  TabmanTestIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
@testable import Tabman

class TabmanTestIndicator: TabmanIndicator {
    
    private(set) var wasConstructed: Bool = false
    
    override func constructIndicator() {
        super.constructIndicator()
        self.wasConstructed = true
    }
}

