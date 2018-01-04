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
        guard #available(iOSApplicationExtension 9, *) else {
            return nil
        }
        
        guard !Bundle.main.bundlePath.hasSuffix("appex") else {
            return nil
        }
        guard UIApplication.responds(to: Selector(("sharedApplication"))) else {
            return nil
        }
        guard let unmanagedSharedApplication = UIApplication.perform(Selector(("sharedApplication"))) else {
            return nil
        }
        
        return unmanagedSharedApplication.takeUnretainedValue() as? UIApplication
    }
}
