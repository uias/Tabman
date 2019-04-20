//
//  TMHidingBar+Triggers.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/12/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal class TMAutoHidingTriggerHandler {
    
    // MARK: Properties
    
    internal private(set) weak var bar: TMHidingBar!
    
    var viewController: UIViewController? {
        return bar.delegate as? UIViewController
    }
    
    // MARK: Init
    
    init(for bar: TMHidingBar) {
        self.bar = bar
    }
    
    // MARK: Lifecycle
    
    func invalidate(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        bar.performShow(animated: animated, completion: completion)
    }
}

internal class TMAutoHidingTimeTriggerHandler: TMAutoHidingTriggerHandler {
    
    // MARK: Properties
    
    let duration: TimeInterval
    
    private var timer: Timer?
    
    // MARK: Init
    
    init(for bar: TMHidingBar, duration: TimeInterval) {
        self.duration = duration
        super.init(for: bar)
        
        resetDismissTimer()
    }
    
    @available(*, unavailable)
    override init(for bar: TMHidingBar) {
        fatalError()
    }
    
    // MARK: Overrides
    
    override func invalidate(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        super.invalidate(animated: animated, completion: completion)
        resetDismissTimer()
    }
    
    // MARK: Timers
    
    private func resetDismissTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: duration,
                                     target: self,
                                     selector: #selector(timerFired(_:)),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc private func timerFired(_ sender: Timer) {
        bar.hide(animated: true, completion: nil)
    }
}
