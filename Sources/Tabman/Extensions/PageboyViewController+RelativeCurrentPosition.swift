//
//  PageboyViewController+RelativeCurrentPosition.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/10/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import Pageboy

internal extension PageboyViewController {
    
    var relativeCurrentPosition: CGFloat? {
        guard let position = self.currentPosition else {
            return nil
        }
        return self.navigationOrientation == .horizontal ? position.x : position.y
    }
}
