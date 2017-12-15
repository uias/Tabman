//
//  UIApplication+ExtensionSafe.swift
//  Tabman-Example
//
//  Created by Oskar Groth on 2017-12-15.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    static var safeShared: UIApplication? {
        guard !Bundle.main.bundlePath.hasSuffix("appex") else { return nil }
        return UIApplication.shared
    }
    
}
