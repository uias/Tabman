//
//  RandientTests.swift
//  RandientTests
//
//  Created by Merrick Sapsford on 04/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import XCTest
@testable import Randient

class RandientTests: XCTestCase {

    func testNewGradientVerification() {
        let gradient = Randient.randomize()
        let verifiedGradient = Randient.verifyNewGradient(gradient)
        XCTAssertNil(verifiedGradient)
    }
}
