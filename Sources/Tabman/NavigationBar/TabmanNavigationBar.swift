//
//  TabmanNavigationBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

open class TabmanNavigationBar: UIView {
    
    // MARK: Properties
    
    private let bar: Bar
    private var barView: UIView {
        return bar as! UIView
    }
    
    private let extendingView = UIView()
    
    public let background = BarBackground(style: .blur(style: .light))
    
    // MARK: Init
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(for:viewController:) - TabmanNavigationBar does not support Interface Builder")
    }
    
    public required init(for bar: Bar) {
        self.bar = bar
        super.init(frame: .zero)
        
        layout(in: self)
    }
    
    private func layout(in view: UIView) {
        
        addSubview(extendingView)
        extendingView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barView.topAnchor.constraint(equalTo: topAnchor),
            barView.trailingAnchor.constraint(equalTo: trailingAnchor),
            barView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        extendingView.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: extendingView.leadingAnchor),
            background.topAnchor.constraint(equalTo: extendingView.topAnchor),
            background.trailingAnchor.constraint(equalTo: extendingView.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: extendingView.bottomAnchor)
            ])
        
    }
    
    // MARK: Layout
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        NSLayoutConstraint.activate([
            extendingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            extendingView.topAnchor.constraint(equalTo: superview!.superview!.topAnchor),
            extendingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            extendingView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}

extension TabmanNavigationBar: Bar {
    
    public weak var dataSource: BarDataSource? {
        get {
            return bar.dataSource
        } set {
            bar.dataSource = newValue
        }
    }
    
    public var delegate: BarDelegate? {
        get {
            return bar.delegate
        } set {
            bar.delegate = newValue
        }
    }
    
    public func reloadData(at indexes: ClosedRange<Int>,
                           context: BarReloadContext) {
        bar.reloadData(at: indexes, context: context)
    }
    
    public func update(for pagePosition: CGFloat,
                       capacity: Int,
                       direction: BarUpdateDirection,
                       shouldAnimate: Bool) {
        bar.update(for: pagePosition,
                   capacity: capacity,
                   direction: direction,
                   shouldAnimate: shouldAnimate)
    }
}
