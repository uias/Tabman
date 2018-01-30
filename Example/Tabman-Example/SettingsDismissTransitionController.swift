//
//  SettingsDismissTransitionController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 27/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

class SettingsDismissTransitionController: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        let screenBounds = UIScreen.main.bounds
        var finalFrame = fromViewController.view.frame
        finalFrame.origin.y = screenBounds.size.height
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: .curveEaseIn,
                       animations: { 
                        fromViewController.view.frame = finalFrame
                        toViewController.view.alpha = 1.0
        }) { (finished) in
            fromViewController.view.removeFromSuperview()
            transitionContext.completeTransition(finished)
        }
    }
}
