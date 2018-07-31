//
//  BarBackgroundView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 31/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

internal class BarBackgroundView: UIView {
    
    // MARK: Init
    
    init(for background: BarBackground) {
        super.init(frame: .zero)
        renderBackground(background)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(for background:)")
    }
    
    // MARK: Background
    
    private func renderBackground(_ background: BarBackground) {
        switch background {
            
        case .blur(let style):
            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
            addSubview(visualEffectView)
            visualEffectView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
        case .flat(let color):
            let view = UIView()
            view.backgroundColor = color
            addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
        default:
            break
        }
    }
}
