//
//  TabViewControllerExtras.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 15/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

extension TabViewController {

    // MARK: Bar buttons

    func addBarButtons() {
        
        let previousBarButton = UIBarButtonItem(title: "First", style: .plain, target: self, action: #selector(firstPage(_:)))
        let nextBarButton = UIBarButtonItem(title: "Last", style: .plain, target: self, action: #selector(lastPage(_:)))
        self.navigationItem.setLeftBarButton(previousBarButton, animated: false)
        self.navigationItem.setRightBarButton(nextBarButton, animated: false)
        self.previousBarButton = previousBarButton
        self.nextBarButton = nextBarButton
        
        self.updateBarButtonStates(index: self.currentIndex ?? 0)
    }
    
    func updateBarButtonStates(index: Int) {
        self.previousBarButton?.isEnabled = index != 0
        self.nextBarButton?.isEnabled = index != (self.pageCount ?? 0) - 1
    }
    
    // MARK: Labels
    
    func updateStatusLabels() {
        self.offsetLabel.text = "Current Position: " + String(format: "%.3f", self.currentPosition?.x ?? 0.0)
        self.pageLabel.text = "Current Page: " + String(describing: self.currentIndex ?? 0)
    }
    
    // MARK: Appearance
    
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
        
        if let topColor = interpolate(betweenColor: lowerGradient.topColor,
                                      and: upperGradient.topColor,
                                      percent: percentage),
            let bottomColor = interpolate(betweenColor: lowerGradient.bottomColor,
                                          and: upperGradient.bottomColor,
                                          percent: percentage) {
            self.gradientView.colors = [topColor, bottomColor]
            
            let midColor = interpolate(betweenColor: topColor, and: bottomColor, percent: 0.1)
            offsetLabel.textColor = midColor
            pageLabel.textColor = midColor
            separatorView.backgroundColor = midColor
            settingsButton.tintColor = midColor
        }
        
    }
    
    func gradient(forIndex index: Int) -> Gradient {
        guard index >= 0 && index < self.gradients.count else {
            return .defaultGradient
        }
        
        return self.gradients[index]
    }
    
    func interpolate(betweenColor colorA: UIColor,
                     and colorB: UIColor,
                     percent: CGFloat) -> UIColor? {
        var redA: CGFloat = 0.0
        var greenA: CGFloat = 0.0
        var blueA: CGFloat = 0.0
        var alphaA: CGFloat = 0.0
        guard colorA.getRed(&redA, green: &greenA, blue: &blueA, alpha: &alphaA) else {
            return nil
        }
        
        var redB: CGFloat = 0.0
        var greenB: CGFloat = 0.0
        var blueB: CGFloat = 0.0
        var alphaB: CGFloat = 0.0
        guard colorB.getRed(&redB, green: &greenB, blue: &blueB, alpha: &alphaB) else {
            return nil
        }
        
        let iRed = CGFloat(redA + percent * (redB - redA))
        let iBlue = CGFloat(blueA + percent * (blueB - blueA))
        let iGreen = CGFloat(greenA + percent * (greenB - greenA))
        let iAlpha = CGFloat(alphaA + percent * (alphaB - alphaA))
        
        return UIColor(red: iRed, green: iGreen, blue: iBlue, alpha: iAlpha)
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
