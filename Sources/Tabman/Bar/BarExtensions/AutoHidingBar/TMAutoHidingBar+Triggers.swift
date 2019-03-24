//
//  TMAutoHidingBar+Triggers.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/12/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal class TMAutoHidingTriggerHandler {
    
    private weak var bar: TMAutoHidingBar!
    
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
    
    // MARK: Init
    
    init(for bar: TMAutoHidingBar, duration: TimeInterval, interactionView: UIView) {
        self.duration = duration
        self.interactionView = interactionView
        super.init(for: bar)
        
        addGestureRecognizer(UITapGestureRecognizer.self, to: interactionView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            bar.hide(animated: true, completion: nil)
        }
    }
    
    @available(*, unavailable)
    override init(for bar: TMAutoHidingBar) {
        fatalError()
    }
    
    deinit {
        gestureRecognizers.forEach({ interactionView?.removeGestureRecognizer($0) })
    }
    
    // MARK: Gestures
    
    private func addGestureRecognizer(_ recognizer: UIGestureRecognizer.Type, to view: UIView) {
        let recognizer = recognizer.init(target: self, action: #selector(gestureActivated(_:)))
        recognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(recognizer)
        gestureRecognizers.append(recognizer)
    }
    
    @objc private func gestureActivated(_ recognizer: UIGestureRecognizer) {
        print("GESTURE")
    }
}
