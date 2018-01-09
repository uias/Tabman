//
//  UIApplication+SafeShared.swift
//  Tabman
//
//  Created by Merrick Sapsford on 05/01/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal extension UIApplication {
    
    static var safeShared: UIApplication? {
        guard #available(iOSApplicationExtension 8, *) else {
            return nil
        }
        
        guard UIApplication.responds(to: NSSelectorFromString("sharedApplication")),
            let unmanagedSharedApplication = UIApplication.perform(NSSelectorFromString("sharedApplication")) else {
                return nil
        }
        
        return unmanagedSharedApplication.takeUnretainedValue() as? UIApplication
    }
}
