//
//  TMBarButton+None.swift
//  Tabman
//
//  Created by Merrick Sapsford on 28/09/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

public extension TMBarButton {
    
    /// Button that is zero height and hidden.
    ///
    /// Use this if you do not want visible buttons in the bar.
    public final class None: TMBarButton {
        
        // MARK: Properties
        
        //swiftlint:disable unused_setter_value
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
