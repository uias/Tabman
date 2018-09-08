//
//  EnumCollection.swift
//  Pageboy-Example
//
//  Created by Merrick Sapsford on 25/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

public protocol EnumCollection: RawRepresentable, Hashable {
    static var all: [Self] { get }
}

extension EnumCollection {
    
    static func cases() -> AnySequence<Self> {
        typealias SelfType = Self
        return AnySequence { () -> AnyIterator<SelfType> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: SelfType.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    static public var all: [Self] {
        return Array(self.cases())
    }
}

