
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
public class TabmanButtonBar: TabmanBar {

    //
    // MARK: Constants
    //
    
    private struct Defaults {
        static let selectedColor: UIColor = .black
        static let color: UIColor = UIColor.black.withAlphaComponent(0.5)
        
        static let horizontalSpacing: CGFloat = 20.0
        
        static let textFont: UIFont = UIFont.systemFont(ofSize: 16.0)
        
        static let height: CGFloat = 50.0
        static let itemImageSize: CGSize = CGSize(width: 25.0, height: 25.0)
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
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: Defaults.height)
    }
    
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
        
        if let textFont = appearance.text.font {
            self.textFont = textFont
            self.updateButtons(update: { (button) in
                button.titleLabel?.font = textFont
            })
        }
        
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
                // resize images to fit
                let resizedImage = image.resize(toSize: Defaults.itemImageSize)
                button.setImage(resizedImage.withRenderingMode(.alwaysTemplate), for: .normal)
            }
            
            // layout
            button.autoPinEdge(toSuperviewEdge: .top)
            button.autoPinEdge(toSuperviewEdge: .bottom)
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
}
