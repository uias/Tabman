//
//  Logger.swift
//  AutoInsetter
//
//  Created by Merrick Sapsford on 24/03/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import Foundation

internal func log(_ message: String) {
    Logger().log(message)
}

private class Logger {
    
    var isEnabled: Bool {
        return UserDefaults.standard.bool(forKey: "AILoggingEnabled")
    }
    
    func log(_ message: String) {
        guard isEnabled else {
            return
        }
        print("[AutoInsetter] - \(message)")
    }
}
