//
//  UIGradientMetadataTests.swift
//  RandientTests
//
//  Created by Merrick Sapsford on 05/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import XCTest
@testable import Randient

class UIGradientMetadataTests: XCTestCase {
    
    func testIsLightAveraging() {
        for gradient in UIGradient.allCases {
            let lightColors = gradient.data.colors.filter({ $0.isLight })
            let darkColors = gradient.data.colors.filter({ !$0.isLight })
            
            let expectedIsLight = lightColors.count > darkColors.count
            XCTAssertEqual(expectedIsLight, gradient.metadata.isPredominantlyLight)
        }
    }
}
