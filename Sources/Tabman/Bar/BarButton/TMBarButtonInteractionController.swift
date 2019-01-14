//
//  TMBarButtonInteractionController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 05/07/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import Foundation

internal protocol TMBarButtonInteractionHandler: class {
    
    func barButtonInteraction(controller: TMBarButtonInteractionController,
                              didHandlePressOf button: TMBarButton,
                              at index: Int)
}

/// A bar button controller that is responsbile for handling interaction that occurs in bar buttons.
internal final class TMBarButtonInteractionController: TMBarButtonController {
    
    // MARK: Properties
    
    private weak var handler: TMBarButtonInteractionHandler?
    
    // MARK: Init
    
    init(for barButtons: [TMBarButton], handler: TMBarButtonInteractionHandler) {
        self.handler = handler
        super.init(for: barButtons)
        
        barButtons.forEach({ (button) in
            button.addTarget(self, action: #selector(barButtonPressed(_:)), for: .touchUpInside)
        })
    }
    
    override init(for barButtons: [TMBarButton]?) {
        fatalError("Use init(for barButtons: handler:)")
    }
    
    // MARK: Actions
    
    @objc private func barButtonPressed(_ sender: TMBarButton) {
        guard let index = barButtons.index(where: { $0.object === sender }) else {
            return
        }
        handler?.barButtonInteraction(controller: self,
                                      didHandlePressOf: sender,
                                      at: index)
    }
}
