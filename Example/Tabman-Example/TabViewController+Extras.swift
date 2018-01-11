//
//  TabViewControllerExtras.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 15/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

extension TabViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Set Up

    func setUp() {
        addBarButtons()
        setUpGradientView()
        setUpAutoScroller()
        
        transition = Transition(style: .push, duration: 1.0)
    }
    
    private func addBarButtons() {
        
        let previousBarButton = UIBarButtonItem(title: "First", style: .plain, target: self, action: #selector(firstPage(_:)))
        let nextBarButton = UIBarButtonItem(title: "Last", style: .plain, target: self, action: #selector(lastPage(_:)))
        self.navigationItem.setLeftBarButton(previousBarButton, animated: false)
        self.navigationItem.setRightBarButton(nextBarButton, animated: false)
        self.previousBarButton = previousBarButton
        self.nextBarButton = nextBarButton
        
        self.updateBarButtonStates(index: self.currentIndex ?? 0)
    }
    
    private func setUpGradientView() {
        view.sendSubview(toBack: self.gradientView)
        gradientView.direction = .custom(start: CGPoint(x: 0.4, y: 0.0),
                                         end: CGPoint(x: 1.0, y: 1.0))
    }
    
    private func setUpAutoScroller() {
        autoScroller.enable(withIntermissionDuration: .short)
        autoScroller.cancelsOnScroll = true
    }
    
    // MARK: Updating
    
    func updateBarButtonStates(index: Int) {
        self.previousBarButton?.isEnabled = index != 0
        self.nextBarButton?.isEnabled = index != (self.pageCount ?? 0) - 1
    }
    
    func updateStatusLabels() {
        self.offsetLabel.text = "Current Position: " + String(format: "%.3f", self.currentPosition?.x ?? 0.0)
        self.pageLabel.text = "Current Page: " + String(describing: self.currentIndex ?? 0)
    }
    
    func updateAppearance(pagePosition: CGFloat) {
        var relativePosition = pagePosition
        if relativePosition < 0.0 {
            relativePosition = 1.0 + relativePosition
        }
        
        let floorOffset = Int(floor(pagePosition))
        let ceilOffset = Int(ceil(pagePosition))
        let lowerIndex =  floorOffset
        let upperIndex = ceilOffset
        
        var integral: Double = 0.0
        let percentage = CGFloat(modf(Double(relativePosition), &integral))
        
        let lowerGradient = self.gradient(forIndex: lowerIndex)
        let upperGradient = self.gradient(forIndex: upperIndex)
        
        var newColors = [UIColor]()
        for (index, color) in lowerGradient.colors.enumerated() {
            let otherColor: UIColor
            if upperGradient.colors.count > index {
                otherColor = upperGradient.colors[index]
            } else {
                otherColor = .black
            }
            
            if let newColor = color.interpolate(between: otherColor, percent: percentage) {
                newColors.append(newColor)
            }
        }
        self.gradientView.colors = newColors
        
        offsetLabel.textColor = .white
        pageLabel.textColor = .white
        separatorView.backgroundColor = .white
        settingsButton.tintColor = .white
    }
    
    func gradient(forIndex index: Int) -> Gradient {
        guard index >= 0 && index < self.gradients.count else {
            return .defaultGradient
        }
        
        return self.gradients[index]
    }
}

extension TabViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SettingsPresentTransitionController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SettingsDismissTransitionController()
    }
}
