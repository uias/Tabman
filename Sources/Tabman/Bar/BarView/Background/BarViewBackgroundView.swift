//
//  BarBackgroundView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 31/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal class BarViewBackgroundView: UIView {
    
    // MARK: Init
    
    init(for background: BarViewBackground) {
        super.init(frame: .zero)
        renderBackground(background)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(for background:)")
    }
    
    // MARK: Background
    
    private func renderBackground(_ background: BarViewBackground) {
        switch background {
            
        case .blur(let style):
            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
            addSubview(visualEffectView)
            visualEffectView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
                visualEffectView.topAnchor.constraint(equalTo: topAnchor),
                visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
                visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            
        case .flat(let color):
            let view = UIView()
            view.backgroundColor = color
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.topAnchor.constraint(equalTo: topAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            
        default:
            break
        }
    }
}
