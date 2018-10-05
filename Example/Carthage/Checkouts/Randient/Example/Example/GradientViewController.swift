//
//  GradientViewController.swift
//  Example
//
//  Created by Merrick Sapsford on 09/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Randient

class GradientViewController: UIViewController, Themeable {

    @IBOutlet private weak var randientView: RandientView!
    @IBOutlet private weak var headerView: GradientInfoHeaderView!
    
    private var currentTheme: Theme?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if currentTheme == .dark {
            return .lightContent
        }
        return .default
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient: UIGradient = randientView.gradient
        headerView.nameLabel.text = gradient.data.name
        applyTheme(for: gradient, animated: false)
    }
    
    // MARK: Actions
    
    @IBAction private func randomizeButtonPressed(_ sender: UIButton) {
        let gradient = randientView.randomize(animated: true)
        headerView.nameLabel.text = gradient.data.name
        applyTheme(for: gradient, animated: true)
    }
}

private extension GradientViewController {
    
    func applyTheme(for gradient: UIGradient, animated: Bool) {
        let theme: Theme = gradient.metadata.isPredominantlyLight ? .light : .dark
        guard theme != self.currentTheme else {
            return
        }
        self.currentTheme = theme
        applyTheme(theme, animated: animated)
        
        if animated {
            UIView.animate(withDuration: 1.0) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
}

