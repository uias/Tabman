//
//  MockBarView.swift
//  TabmanTests
//
//  Created by Merrick Sapsford on 01/09/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import Foundation
import UIKit
@testable import Tabman
import Pageboy

class MockBarView: UIView, TMBar {
    
    private(set) var items: [TMBarItemable]?
    
    weak var dataSource: TMBarDataSource?
    weak var delegate: TMBarDelegate?
    
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
    
    func reloadData(at indexes: ClosedRange<Int>, context: TMBarReloadContext) {
        
    }
    
    func update(for pagePosition: CGFloat, capacity: Int, direction: TMBarUpdateDirection, animation: TMAnimation) {
        
    }
}
