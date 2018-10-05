//
//  Randient.swift
//  Randient
//
//  Created by Merrick Sapsford on 09/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

public class Randient {
    
    /// The last randomized gradient.
    private static var lastGradient: UIGradient?
    
    /// Randomly select a new gradient from `UIGradients`.
    ///
    /// - Returns: Randomly selected gradient.
    public class func randomize() -> UIGradient {
        let allGradients = UIGradient.allCases
        let index = Int.random(in: 0 ..< allGradients.count)
        
        if let newGradient = verifyNewGradient(allGradients[index]) {
            return newGradient
        } else {
            return randomize()
        }
    }
    
    /// Verify that the new gradient can be used.
    ///
    /// Checks that it is not equal to the previously returned gradient.
    ///
    /// - Parameter gradient: New gradient.
    /// - Returns: Gradient if it can be used.
    internal class func verifyNewGradient(_ gradient: UIGradient) -> UIGradient? {
        guard gradient.data.colors != lastGradient?.data.colors else {
            return nil
        }
        
        self.lastGradient = gradient
        return gradient
    }
}
