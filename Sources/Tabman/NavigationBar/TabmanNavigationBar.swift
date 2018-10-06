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
    
    let safeContainer = UIView()
    
    // MARK: Init
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(for bar: Bar) - TabmanNavigationBar does not support Interface Builder")
    }
    
    public required init(for bar: Bar) {
        self.bar = bar
        super.init(frame: .zero)
        
        layout(in: self)
    }
    
    // MARK: Lifecycle
    
    private func layout(in view: UIView) {
        
        view.addSubview(safeContainer)
        safeContainer.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11, *) {
            NSLayoutConstraint.activate([
                safeContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                safeContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                safeContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                safeContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        } else {
            NSLayoutConstraint.activate([
                safeContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                safeContainer.topAnchor.constraint(equalTo: view.topAnchor),
                safeContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                safeContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
        }
        
        safeContainer.addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barView.leadingAnchor.constraint(equalTo: safeContainer.leadingAnchor),
            barView.topAnchor.constraint(equalTo: safeContainer.topAnchor),
            barView.trailingAnchor.constraint(equalTo: safeContainer.trailingAnchor),
            barView.bottomAnchor.constraint(equalTo: safeContainer.bottomAnchor)
            ])
        
        backgroundColor = .blue
        safeContainer.backgroundColor = .red
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
