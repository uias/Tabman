//
//  TMBar+Templates.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import Foundation

public extension TMBar {
 
    /// The default button bar, very reminiscent of the Android `FragmentPagerAdapter`. It consists
    /// of a horizontal layout containing label bar buttons, and a line indicator at the bottom.
    public typealias ButtonBar = TMBarView<TMHorizontalBarLayout, TMLabelBarButton, TMLineBarIndicator>
    /// iOS 'UITabBar' style bar, featuring a constrained horizontal layout, tab item bar buttons with a
    /// vertically aligned image and label, and no visible indicator.
    public typealias TabBar = TMBarView<TMConstrainedHorizontalBarLayout, TMTabItemBarButton, TMBarIndicator.None>
    /// Bar which features only a line indicator, and no buttons.
    public typealias LineBar = TMBarView<TMBarLayout.None, TMBarButton.None, TMLineBarIndicator>
}
