//
//  TMSystemBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/10/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

public extension TMBar {
    
    /// Embed the bar in a 'system' bar that will mimick `UINavigationBar` and `UITabBar`.
    ///
    /// - Returns: System bar.
    public func systemBar() -> TMSystemBar {
        return TMSystemBar(for: self)
    }
}

/// Bar which mimicks the appearance of a UIKit `UINavigationBar` / `UITabBar`.
///
/// Contains an internal `TMBar` and forwards on all bar responsibility to this instance.
public final class TMSystemBar: UIView {
    
    // MARK: Properties
    
    public let bar: TMBar
    
    private lazy var contentView = makeContentView()
    private var barView: UIView? {
        return bar as? UIView
    }

    private lazy var extendingView = UIView()
    private lazy var backgroundView = TMBarBackgroundView(style: self.backgroundStyle)

    private var hasExtendedEdges: Bool = false
    
    @available(*, unavailable)
    public override var backgroundColor: UIColor? {
        didSet {}
    }
    /// Background style of the system bar.
    ///
    /// Defaults to `.blur(style: .extraLight)`.
    public var backgroundStyle: TMBarBackgroundView.Style = .blur(style: .extraLight) {
        didSet {
            backgroundView.style = backgroundStyle
        }
    }
    /// Color of the separator at the edges of the system bar.
    ///
    /// Defaults to `UIColor.white.withAlphaComponent(0.5)`.
    public var separatorColor: UIColor = UIColor.white.withAlphaComponent(0.5) {
        didSet {
            contentView.arrangedSubviews.filter({ $0 is SeparatorView }).forEach { (view) in
                view.backgroundColor = separatorColor
                view.isHidden = separatorColor == .clear
            }
        }
    }
    
    // MARK: Init
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Interface Builder is not supported")
    }
    
    /// Create a system bar.
    ///
    /// - Parameter bar: Bar to embed in the system bar.
    internal init(for bar: TMBar) {
        self.bar = bar
        super.init(frame: .zero)
        
        layout(in: self)
    }
    
    private func layout(in view: UIView) {
        guard let barView = self.barView else {
            fatalError("For some reason we couldn't get barView - this should be impossible.")
        }
        
        // Extended views
        
        view.addSubview(extendingView)
        extendingView.translatesAutoresizingMaskIntoConstraints = false
        
        extendingView.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: extendingView.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: extendingView.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: extendingView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: extendingView.bottomAnchor)
            ])
        
        // Content
        
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        removeSubviewBackgrounds(from: barView)
        contentView.addArrangedSubview(barView)
    }
    
    // MARK: Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        superview?.layoutIfNeeded()
        
        extendViewEdgesIfNeeded()
    }
    
    private func extendViewEdgesIfNeeded() {
        guard let superview = self.superview, !hasExtendedEdges else {
            return
        }
        guard let viewController = nextViewControllerInResponderChain() else {
            fatalError("\(type(of: self)) could not find view controller to use for layout guides.")
        }
        hasExtendedEdges = true
        viewController.view.layoutIfNeeded()
        
        var constraints = [
            extendingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            extendingView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        let safeAreaInsets: UIEdgeInsets
        if #available(iOS 11, *) {
            safeAreaInsets = viewController.view.safeAreaInsets
        } else {
            safeAreaInsets = UIEdgeInsets(top: viewController.topLayoutGuide.length,
                                          left: 0.0,
                                          bottom: viewController.bottomLayoutGuide.length,
                                          right: 0.0)
        }
        
        let relativeFrame = viewController.view.convert(self.frame, from: superview)
        if relativeFrame.origin.y == safeAreaInsets.top { // Pin to top anchor
            constraints.append(contentsOf: [
                extendingView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
                extendingView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            contentView.addArrangedSubview(makeSeparatorView())
        } else if relativeFrame.maxY == (viewController.view.bounds.size.height - safeAreaInsets.bottom) { // Pin to bottom anchor
            constraints.append(contentsOf: [
                extendingView.topAnchor.constraint(equalTo: topAnchor),
                extendingView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
                ])
            contentView.insertArrangedSubview(makeSeparatorView(), at: 0)
        } else { // Don't do any extension
            constraints.append(contentsOf: [
                extendingView.topAnchor.constraint(equalTo: topAnchor),
                extendingView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            contentView.insertArrangedSubview(makeSeparatorView(), at: 0)
            contentView.addArrangedSubview(makeSeparatorView())
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Traverses superview responder chain for the next `UIViewController`.
    ///
    /// Not so nice, but prevents having to inject a reference `UIViewController` as we need the layout guides.
    ///
    /// - Returns: Next view controller in responder chain.
    private func nextViewControllerInResponderChain() -> UIViewController? {
        var superview: UIView! = self.superview
        while superview != nil {
            if let viewController = superview.next as? UIViewController {
                return viewController
            }
            superview = superview.superview
        }
        return nil
    }
    
    /// Removes backgrounds from any subviews (including TMBarBackgroundView)
    ///
    /// - Parameter view: View to remove backgrounds from.
    func removeSubviewBackgrounds(from view: UIView) {
        for subview in view.subviews {
            subview.backgroundColor = .clear
            if let backgroundView = subview as? TMBarBackgroundView {
                backgroundView.style = .clear
            }
        }
    }
}

extension TMSystemBar: TMBar {
    
    public weak var dataSource: TMBarDataSource? {
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
    
    public func reloadData(at indexes: ClosedRange<Int>,
                           context: TMBarReloadContext) {
        bar.reloadData(at: indexes, context: context)
    }
    
    public func update(for pagePosition: CGFloat, capacity: Int, direction: TMBarUpdateDirection, animation: TMAnimation) {
        bar.update(for: pagePosition, capacity: capacity, direction: direction, animation: animation)
    }
}

private extension TMSystemBar {
    
    func makeContentView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }
    
    func makeSeparatorView() -> SeparatorView {
        let view = SeparatorView()
        view.backgroundColor = self.separatorColor
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 0.25)
            ])
        return view
    }
}

private final class SeparatorView: UIView {}
