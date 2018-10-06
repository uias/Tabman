//
//  TabmanBar+Templates.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

public extension TabmanBar {
 
    public typealias Buttons = BarView<HorizontalBarLayout, LabelBarButton, LineBarIndicator>
    public typealias Tabs = BarView<ConstrainedHorizontalBarLayout, TabItemBarButton, BarIndicator.None>
    public typealias Line = BarView<BarLayout.None, BarButton.None, LineBarIndicator>
}
