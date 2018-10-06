//
//  TMBar+Templates.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

public extension TMBar {
 
    public typealias Buttons = TMBarView<TMHorizontalBarLayout, TMLabelBarButton, LineBarIndicator>
    public typealias Tabs = TMBarView<TMConstrainedHorizontalBarLayout, TMTabItemBarButton, BarIndicator.None>
    public typealias Line = TMBarView<TMBarLayout.None, TMBarButton.None, LineBarIndicator>
}
