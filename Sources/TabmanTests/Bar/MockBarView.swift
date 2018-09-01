//
//  MockBarView.swift
//  TabmanTests
//
//  Created by Merrick Sapsford on 01/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation
@testable import Tabman
import Pageboy

class MockBarView: UIView, Bar {
    
    weak var dataSource: BarDataSource?
    weak var delegate: BarDelegate?
    
    // MARK: Lifecycle
    
    init(height: CGFloat = 50.0) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Supported")
    }
    
    // MARK: Bar
    
    func reloadData(for viewController: TabmanViewController,
                    at indexes: ClosedRange<Int>,
                    context: BarReloadContext) {
        
    }
    
    func update(for pagePosition: CGFloat,
                capacity: Int,
                direction: PageboyViewController.NavigationDirection,
                shouldAnimate: Bool) {
        
    }
}
