//
//  TMHorizontalBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

/// Layout that displays bar buttons sequentially along the horizontal axis.
///
/// Simple but versatile, `TMHorizontalBarLayout` lays `BarButton`s out in a horizontal `UIStackView`.
open class TMHorizontalBarLayout: TMBarLayout {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let interButtonSpacing: CGFloat = 16.0
        static let minimumRecommendedButtonWidth: CGFloat = 40.0
    }
    
    // MARK: Properties
    
    internal let stackView = UIStackView()
    internal private(set) var separators = [TMBarButton: SeparatorView]()
    
    // MARK: Customization
    
    open override var contentMode: TMBarLayout.ContentMode {
        didSet {
            switch contentMode {
            case .intrinsic:
                buttonDistribution = .fill
            case .fit:
                buttonDistribution = .fillEqually
            }
        }
    }
    /// Spacing between each button.
    open var interButtonSpacing = Defaults.interButtonSpacing {
        didSet {
            reloadInterButtonSpacing()
        }
    }
    /// Distribution of internal stack view.
    private var buttonDistribution: UIStackView.Distribution {
        get {
            return stackView.distribution
        }
        set {
            stackView.distribution = newValue
        }
    }
    
    // MARK: Separators
    
    /// Whether to display vertical separators between each button.
    ///
    /// If set to `true`, the separators will display between each button
    /// at intervals half way along the `interButtonSpacing` value.
    ///
    /// Defaults to `false`.
    open var showSeparators: Bool = false {
        didSet {
            guard showSeparators != oldValue else {
                return
            }
            reloadInterButtonSpacing()
            setNeedsReload()
        }
    }
    
    private var _separatorColor: UIColor?
    /// The color of vertical separators if they are visible.
    ///
    /// Defaults to the system tint color.
    open var separatorColor: UIColor? {
        get {
            return separators.values.first?.tintColor ?? _separatorColor
        }
        set {
            _separatorColor = newValue
            separators.values.forEach({ $0.tintColor = newValue })
        }
    }
    private var _separatorInset: UIEdgeInsets?
    /// Inset to apply to vertical separators if they are visible.
    ///
    /// Applying values to the vertical (top / bottom) values will inset
    /// the separator from the vertical bounds of the button. Adding value to the
    /// horizontal values (left / right) will effectively increase the padding around
    /// the separator, in addition to the layout spacing.
    ///
    /// Defaults to `UIEdgeInsets(top: 4.0, left: 0.0, bottom: 4.0, right: 0.0)`.
    open var separatorInset: UIEdgeInsets? {
        get {
            return separators.values.first?.contentInset ?? _separatorInset
        }
        set {
            _separatorInset = newValue
            separators.values.forEach({ $0.contentInset = newValue })
        }
    }
    private var _separatorWidth: CGFloat?
    /// Width of vertical separators if they are visible.
    ///
    /// Defaults to `1.0`.
    open var separatorWidth: CGFloat? {
        get {
            return separators.values.first?.width ?? _separatorWidth
        }
        set {
            _separatorWidth = newValue
            separators.values.forEach({ $0.width = newValue })
        }
    }
    
    // MARK: Lifecycle
    
    open override func layout(in view: UIView) {
        super.layout(in: view)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        stackView.spacing = interButtonSpacing
    }
    
    open override func insert(buttons: [TMBarButton], at index: Int) {
        super.insert(buttons: buttons, at: index)
        
        var currentIndex = index
        for button in buttons {
            
            var separator: SeparatorView?
            if showSeparators, button !== buttons.last {
                separator = makeSeparator()
            }
            
            if index >= stackView.arrangedSubviews.count { // just add
                stackView.addArrangedSubview(button)
                if let separator = separator {
                    stackView.addArrangedSubview(separator)
                }
            } else {
                stackView.insertArrangedSubview(button, at: currentIndex)
                if let separator = separator {
                    stackView.insertArrangedSubview(separator, at: currentIndex + 1)
                }
            }
            
            separators[button] = separator
            if separator != nil {
                currentIndex += 2
            } else {
                currentIndex += 1
            }
        }
    }
    
    open override func remove(buttons: [TMBarButton]) {
        super.remove(buttons: buttons)
        
        for button in buttons {
            stackView.removeArrangedSubview(button)
            button.removeFromSuperview()
            
            if let separator = separators[button] {
                stackView.removeArrangedSubview(separator)
                separator.removeFromSuperview()
            }
        }
    }
    
    open override func focusArea(for position: CGFloat, capacity: Int) -> CGRect {
        let range = BarMath.localIndexRange(for: position, minimum: 0, maximum: capacity - 1)
        let buttons = stackView.arrangedSubviews.compactMap({ $0 as? TMBarButton })
        guard buttons.count > range.upperBound else {
            return .zero
        }
        
        let lowerView = buttons[range.lowerBound]
        let upperView = buttons[range.upperBound]
        
        let progress = BarMath.localProgress(for: position)
        let interpolation = lowerView.frame.interpolate(with: upperView.frame, progress: progress)
        
        return CGRect(x: lowerView.frame.origin.x + interpolation.origin.x,
                      y: 0.0,
                      width: lowerView.frame.size.width + interpolation.size.width,
                      height: view.bounds.size.height)
    }
    
    // MARK: Utility
    
    private func reloadInterButtonSpacing() {
        if showSeparators {
            stackView.spacing = interButtonSpacing / 2
        } else {
            stackView.spacing = interButtonSpacing
        }
    }
    
    private func makeSeparator() -> SeparatorView {
        let separator = SeparatorView()
        separator.tintColor = separatorColor
        separator.contentInset = separatorInset
        separator.width = separatorWidth
        return separator
    }
}
