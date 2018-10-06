//
//  TMBar+Templates.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

public extension TMBar {
 
    public typealias Buttons = TMBarView<HorizontalBarLayout, LabelBarButton, LineBarIndicator>
    public typealias Tabs = TMBarView<ConstrainedHorizontalBarLayout, TabItemBarButton, BarIndicator.None>
    public typealias Line = TMBarView<BarLayout.None, BarButton.None, LineBarIndicator>
}
