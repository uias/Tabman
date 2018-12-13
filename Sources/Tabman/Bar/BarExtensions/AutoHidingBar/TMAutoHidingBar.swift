//
//  TMAutoHidingBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 13/12/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public extension TMBar {
    
    public func autoHiding() -> TMAutoHidingBar {
        return TMAutoHidingBar(for: self)
    }
}

public final class TMAutoHidingBar: UIView {
    
    // MARK: Properties
    
    public let bar: TMBar
    
    // MARK: Init
    
    internal init(for bar: TMBar) {
        self.bar = bar
        super.init(frame: .zero)
        
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
