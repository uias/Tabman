//
//  SettingsPresentTransitionController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 27/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class SettingsPresentTransitionController: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        let screenBounds = UIScreen.main.bounds
        let topOffset: CGFloat = 120.0
        
        var finalFrame = transitionContext.finalFrame(for: toViewController)
        finalFrame.origin.y += topOffset
        finalFrame.size.height -= topOffset
        
        toViewController.view.frame = CGRect(x: 0.0, y: screenBounds.size.height,
                                             width: finalFrame.size.width,
                                             height: finalFrame.size.height)
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: .curveEaseOut,
                       animations: { 
                        toViewController.view.frame = finalFrame
                        fromViewController.view.alpha = 0.5
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}
