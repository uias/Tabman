//
//  SettingsPopTransitionController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 28/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class SettingsPopTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        
        let screenBounds = UIScreen.main.bounds
        toViewController.view.frame = finalFrame
        toViewController.view.frame.origin.x -= screenBounds.size.width
        
        containerView.addSubview(toViewController.view)
        
        var fromFinalFrame = fromViewController.view.frame
        fromFinalFrame.origin.x += screenBounds.size.width
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.view.frame = finalFrame
            fromViewController.view.frame = fromFinalFrame
            
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}
