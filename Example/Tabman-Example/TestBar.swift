//
//  TestBar.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 01/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation
import Tabman
import Pageboy

class TestBar: UIView, Bar {
    
    var dataSource: BarDataSource?
    var delegate: BarDelegate?
    
    func reloadData(for tabViewController: TabmanViewController) {
        
    }
    
    func update(for pagePosition: CGFloat, capacity: Int, direction: PageboyViewController.NavigationDirection) {
        
    }
}
