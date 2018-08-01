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

public protocol BarViewDelegate: class {
    
    func barView<LayoutType, BarButtonType>(_ bar: BarView<LayoutType, BarButtonType>,
                                            didRequestScrollToPageAt index: PageboyViewController.PageIndex)
}

public protocol Bar: AnyObject where Self: UIView {
    
    var dataSource: BarViewDataSource? { get set }
    var delegate: BarViewDelegate? { get set }
    
    // Data Source
    func reloadData(for tabViewController: TabmanViewController)
    
    // Updating
    func update(for pagePosition: CGFloat,
                capacity: Int,
                direction: PageboyViewController.NavigationDirection)
}
