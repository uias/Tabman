//
//  SettingsNavigationController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 27/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout

class SettingsNavigationController: UINavigationController {
    
    // MARK: Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.definesPresentationContext = true
        self.providesPresentationContextTransitionStyle = true
        self.modalPresentationCapturesStatusBarAppearance = true
        self.modalPresentationStyle = .overFullScreen
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        self.view.addSubview(blurView)
        self.view.sendSubview(toBack: blurView)
        blurView.autoPinEdgesToSuperviewEdges()
        blurView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
    }
}
