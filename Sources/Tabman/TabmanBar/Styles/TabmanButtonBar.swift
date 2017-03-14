
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
    
    //
    // MARK: Content
    //
    
    internal func addBarButtons(toView view: UIView,
                               items: [TabmanBarItem],
                               customize: (UIButton) -> Void) {
        
        var previousButton: UIButton?
        for (index, item) in items.enumerated() {
            
            let button = UIButton(forAutoLayout: ())
            view.addSubview(button)
            
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleEdgeInsets = UIEdgeInsetsMake(0.0, 4.0, 0.0, 4.0)
            if let title = item.title {
                button.setTitle(title, for: .normal)
            } else if let image = item.image {
                button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            }
            customize(button)
            
            // layout
            button.autoPinEdge(toSuperviewEdge: .top)
            button.autoPinEdge(toSuperviewEdge: .bottom)
            if previousButton == nil {
                button.autoPinEdge(toSuperviewEdge: .left)
            } else {
                button.autoPinEdge(.left, to: .right, of: previousButton!)
                button.autoMatch(.width, to: .width, of: previousButton!)
            }
            if index == items.count - 1 {
                button.autoPinEdge(toSuperviewEdge: .right)
            }
            
            previousButton = button
        }
    }
}
