//
//  MockBarDataSource.swift
//  TabmanTests
//
//  Created by Merrick Sapsford on 01/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation
import Tabman

class MockBarDataSource: TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: "Mock Page \(index)")
    }
}
