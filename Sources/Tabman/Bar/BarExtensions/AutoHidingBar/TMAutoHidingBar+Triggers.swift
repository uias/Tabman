//
//  TMAutoHidingBar+Triggers.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/12/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal class TMAutoHidingTriggerHandler {
    
    // MARK: Properties
    
    internal private(set) weak var bar: TMAutoHidingBar!
    
    var viewController: UIViewController? {
        return bar.delegate as? UIViewController
    }
    
    // MARK: Init
    
    init(for bar: TMAutoHidingBar) {
        self.bar = bar
    }
    
    // MARK: Lifecycle
    
    func invalidate() {
        bar.show(animated: true, completion: nil)
    }
}

internal class TMAutoHidingTimeTriggerHandler: TMAutoHidingTriggerHandler {
    
    // MARK: Properties
    
    private var gestureRecognizers = [UIGestureRecognizer]()
    private weak var interactionView: UIView?
    
    let duration: TimeInterval
    
    private var timer: Timer?
    
    // MARK: Init
    
    init(for bar: TMAutoHidingBar, duration: TimeInterval, interactionView: UIView) {
        self.duration = duration
        self.interactionView = interactionView
        super.init(for: bar)
        
        addGestureRecognizer(UITapGestureRecognizer.self, to: interactionView)
        
        resetDismissTimer()
    }
    
    @available(*, unavailable)
    override init(for bar: TMAutoHidingBar) {
        fatalError()
    }
    
    deinit {
        gestureRecognizers.forEach({ interactionView?.removeGestureRecognizer($0) })
    }
    
    // MARK: Overrides
    
    override func invalidate() {
        super.invalidate()
        resetDismissTimer()
    }
    
    // MARK: Timers
    
    private func resetDismissTimer() {
        timer?.invalidate()
        if #available(iOSApplicationExtension 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false, block: { (_) in
                self.bar.hide(animated: true, completion: nil)
            })
        }
    }
    
    // MARK: Gestures
    
    private func addGestureRecognizer(_ recognizer: UIGestureRecognizer.Type, to view: UIView) {
        let recognizer = recognizer.init(target: self, action: #selector(gestureActivated(_:)))
        recognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(recognizer)
        gestureRecognizers.append(recognizer)
    }
    
    @objc private func gestureActivated(_ recognizer: UIGestureRecognizer) {
        invalidate()
    }
}
