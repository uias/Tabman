//
//  Bar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 28/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit
import Pageboy

public protocol BarViewDataSource: class {
    
    func barItem(for tabViewController: TabmanViewController, at index: Int) -> BarItem?
}

internal protocol BarViewDelegate: class {
    
    func barView<LayoutType, BarButtonType>(_ bar: BarView<LayoutType, BarButtonType>,
                                            didRequestScrollToPageAt index: PageboyViewController.PageIndex)
}

public protocol Bar: class {
    
}
