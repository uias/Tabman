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
        case time(duration: TimeInterval)
    }
    
    public enum HideTransition {
        case drawer
        case fade
    }
    
    // MARK: Properties
    
    public let bar: TMBar
    public let trigger: Trigger
    
    private var triggerHandler: TMAutoHidingTriggerHandler!
    
    public var hideTransition: HideTransition = .drawer
    
    // MARK: Init
    
    internal init(for bar: TMBar, trigger: Trigger) {
        self.bar = bar
        self.trigger = trigger
        super.init(frame: .zero)
        
        self.triggerHandler = makeTriggerHandler(for: trigger)
        layout(barView: bar as? UIView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Interface Builder is not supported")
    }
    
    // MARK: Layout
    
    private func layout(barView: UIView?) {
        guard let barView = barView else {
            fatalError("Could not find barView")
        }
        
        addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barView.topAnchor.constraint(equalTo: topAnchor),
            barView.trailingAnchor.constraint(equalTo: trailingAnchor),
            barView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    // MARK: Triggers
    
    private func makeTriggerHandler(for trigger: Trigger) -> TMAutoHidingTriggerHandler {
        switch trigger {
        case .time(let duration):
            return TMAutoHidingTimeTriggerHandler(for: self, duration: duration)
        }
    }
}

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
    }
}
