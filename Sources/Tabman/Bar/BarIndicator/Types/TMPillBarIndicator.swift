//
//  TMPillBarIndicator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 04/05/2020.
//  Copyright © 2020 UI At Six. All rights reserved.
//

import UIKit

/// Indicator that displays a circular dot centered along the X-axis.
open class TMPillBarIndicator: TMBarIndicator {

    // MARK: Properties
    
    private lazy var visualEffectView = UIVisualEffectView(effect: effect)
    
    open override var displayMode: TMBarIndicator.DisplayMode {
        return .fill
    }
    
    open override var additionalContentInset: TMHorizontalInsets {
        return TMHorizontalInsets(left: 8.0, right: 8.0)
    }
    
    private var _effect: UIVisualEffect?
    open var effect: UIVisualEffect! {
        set {
            _effect = newValue
            visualEffectView.effect = effect
        } get {
            let defaultEffect: UIVisualEffect
            if #available(iOS 13, *) {
                defaultEffect = UIBlurEffect(style: .systemThinMaterial)
            } else {
                defaultEffect = UIBlurEffect(style: .light)
            }
            return _effect ?? defaultEffect
        }
    }
    
    // MARK: Lifecycle
    
    open override func layout(in view: UIView) {
        super.layout(in: view)
        
        clipsToBounds = true
        
        view.addSubview(visualEffectView)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor)
        ])
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.size.height / 2
    }
}
