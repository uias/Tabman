//
//  TabmanDistributedButtonBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 23/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout
import Pageboy

/// A bar with static buttons and line indicator.
///
/// Akin to Instagram notification screen etc.
internal class TabmanDistributedButtonBar: TabmanStaticButtonBar {

    //
    // MARK: Properties
    //
    
    public override var interItemSpacing: CGFloat {
        didSet {
            let insets = UIEdgeInsets(top: 0.0, left: interItemSpacing / 2, bottom: 0.0, right: interItemSpacing / 2)
            self.updateButtons(withContext: .all) { (button) in
                button.titleEdgeInsets = insets
                button.imageEdgeInsets = insets
            }
        }
    }
    
    override var color: UIColor {
        didSet {
            guard color != oldValue else { return }
            
            self.updateButtons(withContext: .unselected) { (button) in
                button.tintColor = color
                button.setTitleColor(color, for: .normal)
            }
        }
    }
    
    override var selectedColor: UIColor {
        didSet {
            guard selectedColor != oldValue else { return }
            
            self.updateButtons(withContext: .target) { (button) in
                button.tintColor = selectedColor
                button.setTitleColor(selectedColor, for: .normal)
            }
        }
    }
    
    //
    // MARK: Lifecycle
    //
    
    override func defaultIndicatorStyle() -> TabmanIndicator.Style {
        return .line
    }
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    override func constructTabBar(items: [TabmanBarItem]) {
        super.constructTabBar(items: items)

        self.addAndLayoutBarButtons(toView: self.contentView, items: items) { (button, previousButton) in
            self.buttons.append(button)
            
            button.addTarget(self, action: #selector(tabButtonPressed(_:)), for: .touchUpInside)
        }
    }
    
    //
    // MARK: Content
    //
    
    func addAndLayoutBarButtons(toView view: UIView,
                                items: [TabmanBarItem],
                                customize: TabmanButtonBarItemCustomize) {
        let insets = UIEdgeInsets(top: 0.0,
                                  left: self.interItemSpacing / 2,
                                  bottom: 0.0,
                                  right: self.interItemSpacing / 2)
        self.addBarButtons(toView: view, items: items) { (button, previousButton) in
            
            button.tintColor = self.color
            button.setTitleColor(self.color, for: .normal)
            button.setTitleColor(self.color.withAlphaComponent(0.3), for: .highlighted)
            button.titleEdgeInsets = insets
            button.imageEdgeInsets = insets
            
            if let previousButton = previousButton {
                button.autoMatch(.width, to: .width, of: previousButton)
            }
            
            customize(button, previousButton)
        }
    }
}
