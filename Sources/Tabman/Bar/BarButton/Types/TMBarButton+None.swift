//
//  TMBarButton+None.swift
//  Tabman
//
//  Created by Merrick Sapsford on 28/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public extension TMBarButton {
    
    public final class None: TMBarButton {
        
        // MARK: Properties
        
        public override var isHidden: Bool {
            set {
                super.isHidden = true
            } get {
                return super.isHidden
            }
        }
        
        // MARK: Lifecycle
        
        public override func layout(in view: UIView) {
            super.layout(in: view)
            
            super.isHidden = true
        }
    }
}
