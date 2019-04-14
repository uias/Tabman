//
//  TMHidingBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 13/12/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

extension TMBar {
    
    public func hiding(trigger: TMHidingBar.Trigger) -> TMHidingBar {
        return TMHidingBar(for: self, trigger: trigger)
    }
}

open class TMHidingBar: UIView {
    
    // MARK: Types
    
    public enum Trigger {
        case time(duration: TimeInterval, interactionView: UIView)
        case manual
    }
    
    public enum HideTransition {
        case drawer
        case fade
    }
    
    // MARK: Properties
    
    public let bar: TMBar
    private var barView: UIView {
        #if swift(>=5.0)
        return bar
        #else
        guard let view = self.bar as? UIView else {
            fatalError("Could not find barView")
        }
        return view
        #endif
    }
    private var barViewTopPin: NSLayoutConstraint?

    /// Trigger that causes the bar to hide.
    public let trigger: Trigger
    private var triggerHandler: TMAutoHidingTriggerHandler?
    
    /// Transition to use when hiding and showing the bar.
    ///
    /// Defaults to `.drawer`.
    open var hideTransition: HideTransition = .drawer
    
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
    
    private func makeTriggerHandler(for trigger: Trigger) -> TMAutoHidingTriggerHandler? {
        switch trigger {
        case .time(let duration, let interactionView):
            return TMAutoHidingTimeTriggerHandler(for: self,
                                                  duration: duration,
                                                  interactionView: interactionView)
        case .manual:
            return TMAutoHidingTriggerHandler(for: self)
        }
    }
    
    // MARK: Animations
    
    /// Hide the bar.
    ///
    /// - Parameters:
    ///   - animated: Whether to animate the hide.
    ///   - completion: Completion handler.
    open func hide(animated: Bool, completion: ((Bool) -> Void)?) {
        guard barView.alpha != 0.0 else {
            return
        }
        
        if animated {
            switch hideTransition  {
            case .drawer:
                barViewTopPin?.constant = -barView.bounds.size.height
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                    self.layoutIfNeeded()
                    self.barView.alpha = 0.0
                }, completion: { (isFinished) in
                    if isFinished {
                        self.isUserInteractionEnabled =  false
                    }
                    completion?(isFinished)
                })
            case .fade:
                UIView.animate(withDuration: 0.2, animations: {
                    self.barView.alpha = 0.0
                }, completion: { (isFinished) in
                    if isFinished {
                        self.isUserInteractionEnabled =  false
                    }
                    completion?(isFinished)
                })
            }
        } else {
            barView.alpha = 0.0
            isUserInteractionEnabled = false
        }
    }
    
    /// Show the bar.
    ///
    /// - Parameters:
    ///   - animated: Whether to animate the show.
    ///   - completion: Completion handler.
    open func show(animated: Bool, completion: ((Bool) -> Void)?) {
        guard barView.alpha != 1.0 else {
            return
        }
        
        if animated {
            switch hideTransition {
            case .drawer:
                barViewTopPin?.constant = -barView.bounds.size.height
                layoutIfNeeded()
                
                barViewTopPin?.constant = 0.0
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                    self.layoutIfNeeded()
                    self.barView.alpha = 1.0
                }, completion: { (isFinished) in
                    if isFinished {
                        self.isUserInteractionEnabled = true
                    }
                    completion?(isFinished)
                })
            case .fade:
                UIView.animate(withDuration: 0.2, animations: {
                    self.barView.alpha = 1.0
                }, completion: { (isFinished) in
                    if isFinished {
                        self.isUserInteractionEnabled =  true
                    }
                    completion?(isFinished)
                })
            }
        } else {
            barViewTopPin?.constant = 0.0
            barView.alpha = 1.0
            isUserInteractionEnabled = true
        }
    }
}

// MARK: - Bar Lifecycle
extension TMHidingBar: TMBar {
    
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
        
        triggerHandler?.invalidate()
    }
}
