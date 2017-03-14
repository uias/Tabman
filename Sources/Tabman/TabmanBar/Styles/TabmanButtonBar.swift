
//
//  TabmanButtonBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Pageboy

public class TabmanButtonBar: TabmanBar {

    //
    // MARK: Constants
    //
    
    private struct Defaults {
        static let selectedColor: UIColor = .black
        static let color: UIColor = UIColor.black.withAlphaComponent(0.5)
    }

    
    //
    // MARK: Properties
    //
    
    internal var buttons = [UIButton]()
    
    internal var color: UIColor = Appearance.defaultAppearance.state.color ?? Defaults.color
    internal var selectedColor: UIColor = Appearance.defaultAppearance.state.selectedColor ?? Defaults.selectedColor
    
    internal var currentTargetButton: UIButton? {
        didSet {
            guard currentTargetButton !== oldValue else { return }
            
            currentTargetButton?.setTitleColor(self.selectedColor, for: .normal)
            oldValue?.setTitleColor(self.color, for: .normal)
        }
    }
    
}
