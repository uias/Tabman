
//
//  TabmanButtonBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Pageboy

/// Abstract concrete class for button bars.
internal class TabmanButtonBar: TabmanBar {

    //
    // MARK: Constants
    //
    
    private struct Defaults {
        
        static let minimumItemHeight: CGFloat = 40.0
        static let itemImageSize: CGSize = CGSize(width: 25.0, height: 25.0)
    }
    
    //
    // MARK: Properties
    //
    
    internal var buttons = [UIButton]()
    
    internal var textFont: UIFont = Appearance.defaultAppearance.text.font! {
        didSet {
            guard textFont != oldValue else { return }
            
            self.updateButtons(update: { (button) in
                button.titleLabel?.font = textFont
            })
        }
    }
    internal var color: UIColor = Appearance.defaultAppearance.state.color!
    internal var selectedColor: UIColor = Appearance.defaultAppearance.state.selectedColor!
    
    internal var itemVerticalPadding: CGFloat = Appearance.defaultAppearance.layout.itemVerticalPadding! {
        didSet {
            guard itemVerticalPadding != oldValue else { return }
            
            self.updateButtons { (button) in
                let insets = UIEdgeInsets(top: itemVerticalPadding, left: 0.0,
                                          bottom: itemVerticalPadding, right: 0.0)
                button.contentEdgeInsets = insets
                self.layoutIfNeeded()
            }
        }
    }
    
    internal var horizontalMarginConstraints = [NSLayoutConstraint]()
    internal var edgeMarginConstraints = [NSLayoutConstraint]()
    
    internal var focussedButton: UIButton? {
        didSet {
            guard focussedButton !== oldValue else { return }
            
            focussedButton?.setTitleColor(self.selectedColor, for: .normal)
            focussedButton?.tintColor = self.selectedColor
            oldValue?.setTitleColor(self.color, for: .normal)
            oldValue?.tintColor = self.color
        }
    }
    
    // Public
    
    /// The spacing between each bar item.
    public var interItemSpacing: CGFloat = Appearance.defaultAppearance.layout.interItemSpacing!
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    public override func constructTabBar(items: [TabmanBarItem]) {
        
        self.buttons.removeAll()
        self.horizontalMarginConstraints.removeAll()
        self.edgeMarginConstraints.removeAll()
    }
    
    public override func update(forAppearance appearance: Appearance,
                                defaultAppearance: Appearance) {
        super.update(forAppearance: appearance,
                     defaultAppearance: defaultAppearance)
        
        let color = appearance.state.color
        self.color = color ?? defaultAppearance.state.color!
        
        let selectedColor = appearance.state.selectedColor
        self.selectedColor = selectedColor ?? defaultAppearance.state.selectedColor!
        
        let interItemSpacing = appearance.layout.interItemSpacing
        self.interItemSpacing = interItemSpacing ?? defaultAppearance.layout.interItemSpacing!
        
        let textFont = appearance.text.font
        self.textFont = textFont ?? defaultAppearance.text.font!
        
        let itemVerticalPadding = appearance.layout.itemVerticalPadding
        self.itemVerticalPadding = itemVerticalPadding ?? defaultAppearance.layout.itemVerticalPadding!
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
                // resize images to fit
                let resizedImage = image.resize(toSize: Defaults.itemImageSize)
                button.setImage(resizedImage.withRenderingMode(.alwaysTemplate), for: .normal)
            }
            
            // appearance
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            
            // layout
            NSLayoutConstraint.autoSetPriority(500, forConstraints: {
                button.autoSetDimension(.height, toSize: Defaults.minimumItemHeight)
            })
            button.autoPinEdge(toSuperviewEdge: .top)
            button.autoPinEdge(toSuperviewEdge: .bottom)
            
            let verticalPadding = self.itemVerticalPadding
            let insets = UIEdgeInsets(top: verticalPadding, left: 0.0, bottom: verticalPadding, right: 0.0)
            button.contentEdgeInsets = insets
            
            if previousButton == nil { // pin to left
                self.edgeMarginConstraints.append(button.autoPinEdge(toSuperviewEdge: .leading))
            } else {
                self.horizontalMarginConstraints.append(button.autoPinEdge(.left, to: .right, of: previousButton!))
                if index == items.count - 1 {
                    self.edgeMarginConstraints.append(button.autoPinEdge(toSuperviewEdge: .trailing))
                }
            }
            
            customize(button, previousButton)
            previousButton = button
        }
    }
    
    internal enum ButtonContext {
        case all
        case target
        case unselected
    }
    
    internal func updateButtons(withContext context: ButtonContext = .all, update: (UIButton) -> ()) {
        for button in self.buttons {
            if context == .all ||
                (context == .target && button === self.focussedButton) ||
                (context == .unselected && button !== self.focussedButton) {
                update(button)
            }
        }
    }
    
    //
    // MARK: Actions
    //
    
    internal func tabButtonPressed(_ sender: UIButton) {
        if let index = self.buttons.index(of: sender) {
            self.delegate?.bar(self, didSelectItemAtIndex: index)
        }
    }
}
