//
//  TMBar+Templates.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

public extension TMBar {
 
    public typealias ButtonBar = TMBarView<TMHorizontalBarLayout, TMLabelBarButton, TMLineBarIndicator>
    public typealias TabBar = TMBarView<TMConstrainedHorizontalBarLayout, TMTabItemBarButton, TMBarIndicator.None>
    public typealias LineBar = TMBarView<TMBarLayout.None, TMBarButton.None, TMLineBarIndicator>
}
