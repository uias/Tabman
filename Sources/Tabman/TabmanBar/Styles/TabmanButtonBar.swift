
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
        
        static let horizontalSpacing: CGFloat = 20.0
        
        static let textFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    }
    
    //
    // MARK: Properties
    //
    
    internal var buttons = [UIButton]()
    
    internal var textFont: UIFont = Appearance.defaultAppearance.text.font ?? Defaults.textFont
    internal var color: UIColor = Appearance.defaultAppearance.state.color ?? Defaults.color
    internal var selectedColor: UIColor = Appearance.defaultAppearance.state.selectedColor ?? Defaults.selectedColor
    
    internal var horizontalMarginConstraints = [NSLayoutConstraint]()
    internal var edgeMarginConstraints = [NSLayoutConstraint]()
    
    internal var currentTargetButton: UIButton? {
        didSet {
            guard currentTargetButton !== oldValue else { return }
            
            currentTargetButton?.setTitleColor(self.selectedColor, for: .normal)
            oldValue?.setTitleColor(self.color, for: .normal)
        }
    }
    
    // Public
    
    /// The spacing between each bar item. (Default = 20.0)
    public var interItemSpacing: CGFloat = Appearance.defaultAppearance.layout.interItemSpacing ?? Defaults.horizontalSpacing
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    public override func constructTabBar(items: [TabmanBarItem]) {
        super.constructTabBar(items: items)
        
        self.buttons.removeAll()
        self.horizontalMarginConstraints.removeAll()
        self.edgeMarginConstraints.removeAll()
    }
    
    public override func update(forAppearance appearance: TabmanBar.Appearance) {
        super.update(forAppearance: appearance)
        
        if let interItemSpacing = appearance.layout.interItemSpacing {
            self.interItemSpacing = interItemSpacing
        }
        
        if let color = appearance.state.color {
            self.color = color
            self.updateButtons(withContext: .unselected, update: { button in
                button.setTitleColor(color, for: .normal)
                button.setTitleColor(color.withAlphaComponent(0.3), for: .highlighted)
            })
        }
        
        if let selectedColor = appearance.state.selectedColor {
            self.selectedColor = selectedColor
            self.currentTargetButton?.setTitleColor(selectedColor, for: .normal)
        }
        
        if let textFont = appearance.text.font {
            self.textFont = textFont
            self.updateButtons(update: { (button) in
                button.titleLabel?.font = textFont
            })
        }
        
        if let indicatorColor = appearance.indicator.color {
            self.indicator?.tintColor = indicatorColor
        }
        
//        if let indicatorIsProgressive = appearance.indicator.isProgressive {
//            self.indicatorLeftMargin?.constant = indicatorIsProgressive ? 0.0 : self.edgeInset
//            UIView.animate(withDuration: 0.3, animations: {
//                self.updateForCurrentPosition()
//            })
//        }
        
        if let indicatorWeight = appearance.indicator.lineWeight,
            let lineIndicator = self.indicator as? TabmanLineIndicator {
            lineIndicator.weight = indicatorWeight
        }
    }
    
    //
    // MARK: Content
    //
    
    internal func addBarButtons(toView view: UIView,
                               items: [TabmanBarItem],
                               customize: (_ button: UIButton, _ previousButton: UIButton?) -> Void) {
        
        var previousButton: UIButton?
        for (index, item) in items.enumerated() {
            
            let button = UIButton(forAutoLayout: ())
            view.addSubview(button)
            
            if let title = item.title {
                button.setTitle(title, for: .normal)
            } else if let image = item.image {
                button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            }
            
            // layout
            button.autoPinEdge(toSuperviewEdge: .top)
            button.autoPinEdge(toSuperviewEdge: .bottom)
            if previousButton == nil { // pin to left
                self.edgeMarginConstraints.append(button.autoPinEdge(toSuperviewEdge: .left))
            } else {
                self.horizontalMarginConstraints.append(button.autoPinEdge(.left, to: .right, of: previousButton!))
                if index == items.count - 1 {
                    self.edgeMarginConstraints.append(button.autoPinEdge(toSuperviewEdge: .right))
                }
            }
            
            customize(button, previousButton)
            previousButton = button
        }
    }
    
    private enum ButtonContext {
        case all
        case target
        case unselected
    }
    
    private func updateButtons(withContext context: ButtonContext = .all, update: (UIButton) -> ()) {
        for button in self.buttons {
            if context == .all ||
                (context == .target && button === self.currentTargetButton) ||
                (context == .unselected && button !== self.currentTargetButton) {
                update(button)
            }
        }
    }
}
