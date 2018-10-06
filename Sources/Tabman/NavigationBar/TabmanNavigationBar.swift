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
    
    private weak var viewController: UIViewController!
    
    let safeContainer = UIView()
    
    // MARK: Init
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(for:viewController:) - TabmanNavigationBar does not support Interface Builder")
    }
    
    public required init(for bar: Bar, viewController: UIViewController) {
        self.bar = bar
        self.viewController = viewController
        super.init(frame: .zero)
        
        addSubview(safeContainer)
        safeContainer.translatesAutoresizingMaskIntoConstraints = false
        safeContainer.addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .blue
        safeContainer.backgroundColor = .red
    }
    
    // MARK: Lifecycle
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard safeContainer.constraints.isEmpty else {
            fatalError("Something weird has happened, the navigation bar appears to have already been added to a superview before.")
        }
        
        if #available(iOS 11, *) {
            NSLayoutConstraint.activate([
                safeContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                safeContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                safeContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                safeContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
        } else {
            NSLayoutConstraint.activate([
                safeContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
                safeContainer.topAnchor.constraint(equalTo: viewController.topLayoutGuide.bottomAnchor),
                safeContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
                safeContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
        }
        
        
        NSLayoutConstraint.activate([
            barView.leadingAnchor.constraint(equalTo: safeContainer.leadingAnchor),
            barView.topAnchor.constraint(equalTo: safeContainer.topAnchor),
            barView.trailingAnchor.constraint(equalTo: safeContainer.trailingAnchor),
            barView.bottomAnchor.constraint(equalTo: safeContainer.bottomAnchor)
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
