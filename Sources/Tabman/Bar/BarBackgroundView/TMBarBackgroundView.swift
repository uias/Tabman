//
//  TMBarBackgroundView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 29/08/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

/// A view that displays a specified background style.
open class TMBarBackgroundView: UIView {
    
    /// Style of background.
    ///
    /// - clear: No visible background.
    /// - flat: A flat color background.
    /// - blur: A blurred background with a defined style.
    /// - custom: A custom view to use as the background.
    public enum Style {
        case clear
        case flat(color: UIColor)
        case blur(style: UIBlurEffect.Style)
        case custom(view: UIView)
    }
    
    // MARK: Properties

    /**
     Style of the visible background.
     
     Options: `.clear`, `.flat`, `.blur`, `.custom`.
    **/
    open var style: Style {
        didSet {
            update(for: style)
        }
    }
    
    @available(*, unavailable)
    open override var backgroundColor: UIColor? {
        didSet {
        }
    }
    
    private var backgroundView: UIView?
    
    // MARK: Init
    
    public init(style: Style = .clear) {
        self.style = style
        super.init(frame: .zero)
        
        isUserInteractionEnabled = false
        super.backgroundColor = .clear
        
        update(for: style)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(style:)")
    }
}

private extension TMBarBackgroundView {
    
    func update(for style: Style) {
        cleanUp(backgroundView: backgroundView)
        
        guard let backgroundView = view(for: style) else {
            return
        }
        self.backgroundView = backgroundView
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    func view(for style: Style) -> UIView? {
        switch style {
        case .flat(let color):
            let view = UIView()
            view.backgroundColor = color
            return view
        case .blur(let style):
            let effect = UIBlurEffect(style: style)
            return UIVisualEffectView(effect: effect)
        case .custom(let view):
            if view.superview !== nil {
                view.removeFromSuperview()
            }
            return view
        default:
            return nil
        }
    }
    
    func cleanUp(backgroundView: UIView?) {
        backgroundView?.removeFromSuperview()
    }
}
