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

/// A button tab bar with a block style indicator behind selected item.
///
/// Maximum item limit: 5
public class TabmanBlockTabBar: TabmanButtonBar {
    
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
    
    private var buttonContentView: UIView?
    private var maskContentView: UIView?
    
    // Public
    
    override public var itemCountLimit: Int? {
        return 5
    }
    
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
    
    //
    // MARK: Lifecycle
    //
    
    override public func defaultIndicatorStyle() -> TabmanIndicator.Style {
        return .custom(type: TabmanBlockIndicator.self)
    }
    
    public override func usePreferredIndicatorStyle() -> Bool {
        return false
    }
    
    override func indicatorTransitionType() -> TabmanIndicatorTransition.Type? {
        return TabmanStaticBarIndicatorTransition.self
    }
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    override public func constructTabBar(items: [TabmanBarItem]) {

        let buttonContentView = UIView(forAutoLayout: ())
        let maskContentView = UIView(forAutoLayout: ())
        maskContentView.isUserInteractionEnabled = false
        
        self.contentView.addSubview(buttonContentView)
        buttonContentView.autoPinEdgesToSuperviewEdges()
        self.contentView.addSubview(maskContentView)
        maskContentView.autoPinEdgesToSuperviewEdges()
        maskContentView.mask = self.indicatorMaskView
        
        let insets = UIEdgeInsets(top: 0.0,
                                  left: self.interItemSpacing / 2,
                                  bottom: 0.0,
                                  right: self.interItemSpacing / 2)
        self.addBarButtons(toView: buttonContentView, items: items) { (button, previousButton) in
            self.buttons.append(button)

            button.tintColor = self.color
            button.setTitleColor(self.color, for: .normal)
            button.setTitleColor(self.color.withAlphaComponent(0.3), for: .highlighted)
            button.titleEdgeInsets = insets
            button.imageEdgeInsets = insets
            
            if let previousButton = previousButton {
                button.autoMatch(.width, to: .width, of: previousButton)
            }
            
            button.addTarget(self, action: #selector(tabButtonPressed(_:)), for: .touchUpInside)
        }
        self.addBarButtons(toView: maskContentView, items: items) { (button, previousButton) in
            button.tintColor = self.selectedColor
            button.setTitleColor(self.selectedColor, for: .normal)
            button.titleEdgeInsets = insets
            button.imageEdgeInsets = insets
            
            if let previousButton = previousButton {
                button.autoMatch(.width, to: .width, of: previousButton)
            }
        }
        
        self.buttonContentView = buttonContentView
        self.maskContentView = maskContentView
    }
    
    override public func addIndicatorToBar(indicator: TabmanIndicator) {
        
        self.contentView.addSubview(indicator)
        indicator.autoPinEdge(toSuperviewEdge: .bottom)
        self.indicatorLeftMargin = indicator.autoPinEdge(toSuperviewEdge: .left)
        self.indicatorWidth = indicator.autoSetDimension(.width, toSize: 0.0)
    }

    override public func update(forAppearance appearance: TabmanBar.Appearance) {
        super.update(forAppearance: appearance)
        
        if let color = appearance.state.color {
            self.updateButtonsInView(view: self.buttonContentView, update: { (button) in
                button.tintColor = color
                button.setTitleColor(color, for: .normal)
            })
        }
        
        if let selectedColor = appearance.state.selectedColor {
            self.updateButtonsInView(view: self.maskContentView, update: { (button) in
                button.tintColor = selectedColor
                button.setTitleColor(selectedColor, for: .normal)
            })
        }
    }
    
    //
    // MARK: Button Manipulation
    //
    
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
    
    //
    // MARK: Actions
    //
    
    func tabButtonPressed(_ sender: UIButton) {
        if let index = self.buttons.index(of: sender) {
            self.delegate?.bar(self, didSelectItemAtIndex: index)
        }
    }
}
