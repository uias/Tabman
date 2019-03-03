//
//  ChildViewController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 13/02/2017.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit
import Tabman

class ChildViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var promptLabel: UILabel!

    private var badgeCount = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateIndexLabel()
    }
    
    private func updateIndexLabel() {
        if let index = (pageboyParent as? TabPageViewController)?.viewControllers.index(of: self) {
            label.text = "Page " + String(index + 1)
            
            let isFirstPage = index == 0
            
            var prompt = "(Index \(index))"
            if isFirstPage {
                prompt.append("\n\nswipe me >")
            }
            promptLabel.text = prompt
        }
    }
    
    @IBAction private func badge(_ sender: UIButton) {
        badgeCount = badgeCount == 0 ? 1 : 0
        tabmanBarItems?.forEach({ $0.badgeValue = badgeCount == 1 ? "\(badgeCount)" : nil })
    }
}
