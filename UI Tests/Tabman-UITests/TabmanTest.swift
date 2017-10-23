//
//  TabmanTest.swift
//  Tabman-Tests
//
//  Created by Merrick Sapsford on 13/08/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import UIKit

struct TabmanTest {
    
    let id = UUID().uuidString
    let title: String
    let storyboardId: String?
    let viewControllerId: String?
    let viewControllerType: UIViewController.Type?
    let instances: Int
    
    init(title: String, storyboardId: String, viewControllerId: String, instances: Int) {
        self.title = title
        self.storyboardId = storyboardId
        self.viewControllerId = viewControllerId
        self.viewControllerType = nil
        self.instances = instances
    }
    
    init(title: String, viewControllerType: UIViewController.Type, instances: Int) {
        self.title = title
        self.storyboardId = nil
        self.viewControllerId = nil
        self.viewControllerType = viewControllerType
        self.instances = instances
    }
}

extension TabmanTest: Equatable {
    
    static func ==(lhs: TabmanTest, rhs: TabmanTest) -> Bool {
        return lhs.id == rhs.id
    }
}

struct TabmanTestSection {
    
    let title: String
    private(set) var tests: [TabmanTest]
    
    init(title: String, tests: [TabmanTest]) {
        self.title = title
        self.tests = tests
    }
    
    mutating func add(test: TabmanTest) {
        tests.append(test)
    }
    
    mutating func remove(test: TabmanTest) {
        guard let index = tests.index(of: test) else { return }
        tests.remove(at: index)
    }
}
