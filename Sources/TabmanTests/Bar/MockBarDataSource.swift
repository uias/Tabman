//
//  MockBarDataSource.swift
//  TabmanTests
//
//  Created by Merrick Sapsford on 01/09/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import Foundation
import UIKit
import Tabman

class MockBarDataSource: TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: "Mock Page \(index)")
    }
}
