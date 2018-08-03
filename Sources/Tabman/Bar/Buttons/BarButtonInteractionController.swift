//
//  BarButtonInteractionController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 05/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

internal protocol BarButtonInteractionHandler: class {
    
    func barButtonInteraction(controller: BarButtonInteractionController,
                              didHandlePressOf button: BarButton,
                              at index: Int)
}

internal final class BarButtonInteractionController: BarButtonController {
    
    // MARK: Properties
    
    private weak var handler: BarButtonInteractionHandler?
    
    // MARK: Init
    
    init(for barButtons: [BarButton], handler: BarButtonInteractionHandler) {
        self.handler = handler
        super.init(for: barButtons)
        
        barButtons.forEach({ (button) in
            button.addTarget(self, action: #selector(barButtonPressed(_:)), for: .touchUpInside)
        })
    }
    
    override init(for barButtons: [BarButton]?) {
        fatalError("Use init(for barButtons: handler:)")
    }
    
    // MARK: Actions
    
    @objc private func barButtonPressed(_ sender: BarButton) {
        guard let index = barButtons.index(where: { $0.object === sender }) else {
            return
        }
        handler?.barButtonInteraction(controller: self,
                                      didHandlePressOf: sender,
                                      at: index)
    }
}
