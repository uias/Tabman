//
//  TabmanBlockTabBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 09/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
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
            guard color != oldValue else {
                return
            }
            
            self.updateButtonsInView(view: self.buttonContentView, update: { (button) in
                button.tintColor = color
                button.setTitleColor(color, for: .normal)
            })
        }
    }
    
    override var selectedColor: UIColor {
        didSet {
            guard selectedColor != oldValue else {
                return
            }
            
            self.updateButtonsInView(view: self.maskContentView, update: { (button) in
                button.tintColor = selectedColor
                button.setTitleColor(selectedColor, for: .normal)
            })
        }
    }
    
    override var textFont: UIFont {
        didSet {
            guard textFont != oldValue else {
                return
            }

            updateButtonsInView(view: self.buttonContentView,
                                update: { $0.titleLabel?.font = textFont })
            updateButtonsInView(view: self.maskContentView,
                                update: { $0.titleLabel?.font = textFont })
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
    
    public override func construct(in contentView: UIView,
                                   for items: [TabmanBar.Item]) {
        super.construct(in: contentView, for: items)
        
        let buttonContentView = UIView()
        let maskContentView = UIView()
        maskContentView.isUserInteractionEnabled = false
        
        self.contentView.addSubview(buttonContentView)
        buttonContentView.pinToSuperviewEdges()
        self.contentView.addSubview(maskContentView)
        maskContentView.pinToSuperviewEdges()
        maskContentView.mask = self.indicatorMaskView
        
        self.addAndLayoutBarButtons(toView: buttonContentView, items: items) { (button, _) in
            self.buttons.append(button)
            
            button.addTarget(self, action: #selector(tabButtonPressed(_:)), for: .touchUpInside)
        }
        self.addAndLayoutBarButtons(toView: maskContentView, items: items) { (button, _) in
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
