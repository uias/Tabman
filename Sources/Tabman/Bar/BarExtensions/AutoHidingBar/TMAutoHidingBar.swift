//
//  TMAutoHidingBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 13/12/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public extension TMBar {
    
    public func autoHiding(trigger: TMAutoHidingBar.Trigger) -> TMAutoHidingBar {
        return TMAutoHidingBar(for: self, trigger: trigger)
    }
}

public final class TMAutoHidingBar: UIView {
    
    // MARK: Types
    
    public enum Trigger {
        case time(duration: TimeInterval, interactionView: UIView)
    }
    
    public enum HideTransition {
        case drawer
        case fade
    }
    
    // MARK: Properties
    
    public let bar: TMBar
    private var barView: UIView {
        guard let view = self.bar as? UIView else {
            fatalError("Could not find barView")
        }
        return view
    }
    private var barViewTopPin: NSLayoutConstraint?

    public let trigger: Trigger
    private var triggerHandler: TMAutoHidingTriggerHandler!
    
    public var hideTransition: HideTransition = .drawer
    
    // MARK: Init
    
    internal init(for bar: TMBar, trigger: Trigger) {
        self.bar = bar
        self.trigger = trigger
        super.init(frame: .zero)
        
        self.triggerHandler = makeTriggerHandler(for: trigger)
        
        layout(barView: barView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Interface Builder is not supported")
    }
    
    // MARK: Layout
    
    private func layout(barView: UIView) {
        addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        
        let barViewTopPin = barView.topAnchor.constraint(equalTo: topAnchor)
        NSLayoutConstraint.activate([
            barView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barViewTopPin,
            barView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heightAnchor.constraint(equalTo: barView.heightAnchor, multiplier: 1.0)
            ])
        
        self.barViewTopPin = barViewTopPin
    }
    
    // MARK: Triggers
    
    private func makeTriggerHandler(for trigger: Trigger) -> TMAutoHidingTriggerHandler {
        switch trigger {
        case .time(let duration, let interactionView):
            return TMAutoHidingTimeTriggerHandler(for: self,
                                                  duration: duration,
                                                  interactionView: interactionView)
        }
    }
    
    // MARK: Animations
    
    internal func hide(animated: Bool, completion: ((Bool) -> Void)?) {
        switch hideTransition  {
        case .drawer:
            barViewTopPin?.constant = -barView.bounds.size.height
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.layoutIfNeeded()
                self.barView.alpha = 0.0
            }, completion: completion)
        case .fade:
            UIView.animate(withDuration: 0.2, animations: {
                self.barView.alpha = 0.0
            }, completion: completion)
        }
    }
    
    internal func show(animated: Bool, completion: ((Bool) -> Void)?) {
        switch hideTransition {
        case .drawer:
            barViewTopPin?.constant = 0.0
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                self.layoutIfNeeded()
                self.barView.alpha = 1.0
            }, completion: completion)
        case .fade:
            UIView.animate(withDuration: 0.2, animations: {
                self.barView.alpha = 1.0
            }, completion: completion)
        }
    }
}

// MARK: - Bar Lifecycle
extension TMAutoHidingBar: TMBar {
    
    public var dataSource: TMBarDataSource? {
        get {
            return bar.dataSource
        } set {
            bar.dataSource = newValue
        }
    }
    
    public var delegate: TMBarDelegate? {
        get {
            return bar.delegate
        } set {
            bar.delegate = newValue
        }
    }
    
    public var items: [TMBarItemable]? {
        return bar.items
    }
    
    public func reloadData(at indexes: ClosedRange<Int>, context: TMBarReloadContext) {
        bar.reloadData(at: indexes, context: context)
    }
    
    public func update(for position: CGFloat, capacity: Int, direction: TMBarUpdateDirection, animation: TMAnimation) {
        bar.update(for: position, capacity: capacity, direction: direction, animation: animation)
        
        triggerHandler.invalidate()
    }
}
