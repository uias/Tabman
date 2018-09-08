//
//  PageViewControllerAppearance.swift
//  Pageboy-Example
//
//  Created by Merrick Sapsford on 15/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

extension PageViewController {
    
    // MARK: Bar buttons
    
    func addBarButtonsIfNeeded() {
        guard let navigationItem = parent?.navigationItem, self.previousBarButton == nil else {
            return
        }
        
        let previousBarButton = UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(previousPage(_:)))
        let nextBarButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextPage(_:)))
        navigationItem.setLeftBarButton(previousBarButton, animated: false)
        navigationItem.setRightBarButton(nextBarButton, animated: false)
        self.previousBarButton = previousBarButton
        self.nextBarButton = nextBarButton
        
        updateBarButtonsForCurrentIndex()
    }
    
    func updateBarButtonsForCurrentIndex() {
        guard let index = self.currentIndex else {
            return
        }
        self.previousBarButton?.isEnabled = index != 0
        self.nextBarButton?.isEnabled = index != (pageCount ?? 0) - 1
    }
}
