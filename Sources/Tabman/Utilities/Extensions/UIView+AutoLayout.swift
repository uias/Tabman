//
//  UIView+AutoLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/01/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

// MARK: - AutoLayout helpers
internal extension UIView {
    
    @available (iOS 11, *)
    func pinToSafeArea(layoutGuide: UILayoutGuide) {
        prepareForAutoLayout {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
                self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
                self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
                self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
                ])
        }
    }
    
    func pinToSuperviewEdges() {
        guard let superview = self.superview else {
            fatalError("No superview for view \(self)")
        }
        
        prepareForAutoLayout {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: superview.topAnchor),
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
                ])
        }
    }
    
    private func prepareForAutoLayout(_ completion: () -> Void) {
        self.translatesAutoresizingMaskIntoConstraints = false
        completion()
    }
}
