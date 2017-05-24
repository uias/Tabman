//
//  TabmanBlockTabBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 09/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout
import Pageboy

/// A button tab bar with a block style indicator behind the selected item.
internal class TabmanBlockTabBar: TabmanStaticButtonBar {
    
    // MARK: Properties
    
    private var buttonContentView: UIView?
    private var maskContentView: UIView?
    
    public override var interItemSpacing: CGFloat {
        didSet {
            let insets = UIEdgeInsets(top: 0.0, left: interItemSpacing / 2, bottom: 0.0, right: interItemSpacing / 2)
            self.updateButtonsInView(view: self.buttonContentView) { (button) in
                button.titleEdgeInsets = insets
                button.imageEdgeInsets = insets
            }
            self.updateButtonsInView(view: self.maskContentView) { (button) in
                button.titleEdgeInsets = insets
                button.imageEdgeInsets = insets
            }
        }
    }
    
    override var color: UIColor {
        didSet {
            guard color != oldValue else { return }
            
            self.updateButtonsInView(view: self.buttonContentView, update: { (button) in
                button.tintColor = color
                button.setTitleColor(color, for: .normal)
            })
        }
    }
    
    override var selectedColor: UIColor {
        didSet {
            guard selectedColor != oldValue else { return }
            
            self.updateButtonsInView(view: self.maskContentView, update: { (button) in
                button.tintColor = selectedColor
                button.setTitleColor(selectedColor, for: .normal)
            })
        }
    }
    
    // MARK: Lifecycle

    override public func defaultIndicatorStyle() -> TabmanIndicator.Style {
        return .custom(type: TabmanBlockIndicator.self)
    }
    
    public override func usePreferredIndicatorStyle() -> Bool {
        return false
    }
    
    // MARK: TabmanBar Lifecycle
    
    override public func constructTabBar(items: [TabmanBarItem]) {
        super.constructTabBar(items: items)
        
        let buttonContentView = UIView(forAutoLayout: ())
        let maskContentView = UIView(forAutoLayout: ())
        maskContentView.isUserInteractionEnabled = false
        
        self.contentView.addSubview(buttonContentView)
        buttonContentView.autoPinEdgesToSuperviewEdges()
        self.contentView.addSubview(maskContentView)
        maskContentView.autoPinEdgesToSuperviewEdges()
        maskContentView.mask = self.indicatorMaskView
        
        self.addAndLayoutBarButtons(toView: buttonContentView, items: items) { (button, previousButton) in
            self.buttons.append(button)
            
            button.addTarget(self, action: #selector(tabButtonPressed(_:)), for: .touchUpInside)
        }
        self.addAndLayoutBarButtons(toView: maskContentView, items: items) { (button, previousButton) in
            button.tintColor = self.selectedColor
            button.setTitleColor(self.selectedColor, for: .normal)
        }
        
        self.buttonContentView = buttonContentView
        self.maskContentView = maskContentView
    }
    
    // MARK: Utilities
    
    private func updateButtonsInView(view: UIView?, update: (UIButton) -> Void) {
        guard let view = view else {
            return
        }
        
        for subview in view.subviews {
            if let button = subview as? UIButton {
                update(button)
            }
        }
    }
}
