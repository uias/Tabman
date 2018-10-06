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
    
    private let bar: TabmanBar
    private var barView: UIView {
        return bar as! UIView
    }
    private lazy var backgroundView = BarBackground(style: self.backgroundStyle)
    private lazy var extendingView = UIView()
    private lazy var separatorView = makeSeparatorView()
    
    @available(*, unavailable)
    open override var backgroundColor: UIColor? {
        didSet {}
    }
    public var backgroundStyle: BarBackground.Style = .blur(style: .extraLight) {
        didSet {
            backgroundView.style = backgroundStyle
        }
    }
    
    // MARK: Init
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(for:viewController:) - TabmanNavigationBar does not support Interface Builder")
    }
    
    public required init(for bar: TabmanBar) {
        self.bar = bar
        super.init(frame: .zero)
        
        layout(in: self)
    }
    
    private func layout(in view: UIView) {
        
        addSubview(extendingView)
        extendingView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barView.topAnchor.constraint(equalTo: topAnchor),
            barView.trailingAnchor.constraint(equalTo: trailingAnchor),
            barView.bottomAnchor.constraint(equalTo: separatorView.topAnchor)
            ])
        
        extendingView.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: extendingView.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: extendingView.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: extendingView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: extendingView.bottomAnchor)
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

extension TabmanNavigationBar: TabmanBar {
    
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

private extension TabmanNavigationBar {
    
    func makeSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 0.25)
            ])
        return view
    }
}
