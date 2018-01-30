//
//  TabmanClearIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal class TabmanClearIndicator: TabmanIndicator {

    //
    // MARK: Lifecycle
    //
    
    override func constructIndicator() {
        // do nothing
    }
    
    override func itemTransitionType() -> TabmanItemTransition.Type? {
        return TabmanItemColorCrossfadeTransition.self
    }
}
