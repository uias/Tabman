//
//  BarBackgroundLayoutController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal final class BarBackgroundLayoutController {
    
    // MARK: Properties
    
    private weak var container: UIView!
    private weak var background: BarBackground!
    
    // MARK: Init
    
    init(in container: UIView, for background: BarBackground) {
        self.container = container
        self.background = background
        
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            background.topAnchor.constraint(equalTo: container.topAnchor),
            background.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
    }
}
