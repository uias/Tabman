//
//  TabmanButtonBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

/// Abstract class for button bars.
internal class TabmanButtonBar: TabmanBar {
    
    //
    // MARK: Types
    //
    
    internal typealias TabmanButtonBarItemCustomize = (_ button: UIButton, _ previousButton: UIButton?) -> Void
    
    //
    // MARK: Constants
    //
    
    private struct Defaults {
        static let minimumItemHeight: CGFloat = 40.0
        static let itemImageSize: CGSize = CGSize(width: 25.0, height: 25.0)
        static let titleWithImageSize: CGSize = CGSize(width: 20.0, height: 20.0)
    }
    
    //
    // MARK: Properties
    //
    
    internal var buttons = [UIButton]()
    
    internal var horizontalMarginConstraints = [NSLayoutConstraint]()
    internal var edgeMarginConstraints = [NSLayoutConstraint]()
    
    private var isAnimatingFocussedButton: Bool = false
    internal var focussedButton: UIButton? {
        didSet {
            guard focussedButton !== oldValue else {
                return
            }
            
            let update = {
                self.focussedButton?.setTitleColor(self.selectedColor, for: .normal)
                self.focussedButton?.tintColor = self.selectedColor
                self.focussedButton?.titleLabel?.font = self.selectedTextFont
                oldValue?.setTitleColor(self.color, for: .normal)
                oldValue?.tintColor = self.color
                oldValue?.titleLabel?.font = self.textFont
            }
            
            // If animating between buttons then dont use a transition - only for scroll events
            if isAnimatingFocussedButton {
                update()
            } else {
                guard let transitionView = focussedButton ?? oldValue else {
                    update()
                    return
                }
                UIView.transition(with: transitionView, duration: 0.2, options: .transitionCrossDissolve, animations: {
                    update()
                }, completion: nil)
            }
        }
    }
    
    public var textFont: UIFont = Appearance.defaultAppearance.text.font! {
        didSet {
            updateButtons { (button) in
                button.titleLabel?.font = textFont
            }
        }
    }
    public var selectedTextFont: UIFont = Appearance.defaultAppearance.text.font! {
        didSet {
            focussedButton?.titleLabel?.font = selectedTextFont
        }
    }

    public var color: UIColor = Appearance.defaultAppearance.state.color!
    public var selectedColor: UIColor = Appearance.defaultAppearance.state.selectedColor!
  
    public var imageRenderingMode: UIImageRenderingMode = Appearance.defaultAppearance.style.imageRenderingMode! {
        didSet {
            guard oldValue != imageRenderingMode else {
                return
            }
            updateButtons(update: {
                guard let image = $0.currentImage else {
                    return
                }
                $0.setImage(image.withRenderingMode(imageRenderingMode), for: .normal)
            })
        }
    }
    
    public var itemVerticalPadding: CGFloat = Appearance.defaultAppearance.layout.itemVerticalPadding! {
        didSet {
            guard itemVerticalPadding != oldValue else {
                return
            }
            
            self.updateButtons { (button) in
                let insets = UIEdgeInsets(top: itemVerticalPadding, left: 0.0,
                                          bottom: itemVerticalPadding, right: 0.0)
                button.contentEdgeInsets = insets
                self.layoutIfNeeded()
            }
        }
    }
    /// The spacing between each bar item.
    public var interItemSpacing: CGFloat = Appearance.defaultAppearance.layout.interItemSpacing! {
        didSet {
            self.updateConstraints(self.horizontalMarginConstraints,
                                   withValue: interItemSpacing)
            self.layoutIfNeeded()
            self.updateForCurrentPosition()
        }
    }
    
    /// The inset at the edge of the bar items.
    public var edgeInset: CGFloat = Appearance.defaultAppearance.layout.edgeInset! {
        didSet {
            self.updateConstraints(self.edgeMarginConstraints,
                                   withValue: edgeInset)
            self.layoutIfNeeded()
            self.updateForCurrentPosition()
        }
    }
    
    /// Check if a button should response to events
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        guard let button = view as? UIButton, let index = self.buttons.index(of: button) else {
            return view
        }
        
        guard self.responder?.bar(self, shouldSelectItemAt: index) ?? true else {
            return nil
        }
        
        return view
    }
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    public override func construct(in contentView: UIView,
                                   for items: [TabmanBar.Item]) {
        
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
        
        let selectedTextFont = appearance.text.selectedFont
        self.selectedTextFont = selectedTextFont ?? self.textFont

        let itemVerticalPadding = appearance.layout.itemVerticalPadding
        self.itemVerticalPadding = itemVerticalPadding ?? defaultAppearance.layout.itemVerticalPadding!
        
        let edgeInset = appearance.layout.edgeInset
        self.edgeInset = edgeInset ?? defaultAppearance.layout.edgeInset!
        
        self.imageRenderingMode = appearance.style.imageRenderingMode ?? defaultAppearance.style.imageRenderingMode!
        
        // update left margin for progressive style
        if self.indicator?.isProgressiveCapable ?? false {
            
            let indicatorIsProgressive = appearance.indicator.isProgressive ?? defaultAppearance.indicator.isProgressive!
            let leftMargin = self.indicatorLeftMargin?.constant ?? 0.0
            let indicatorWasProgressive = leftMargin == 0.0
            
            if indicatorWasProgressive && !indicatorIsProgressive {
                self.indicatorLeftMargin?.constant = leftMargin - self.edgeInset
            } else if !indicatorWasProgressive && indicatorIsProgressive {
                self.indicatorLeftMargin?.constant = 0.0
            }
        }
    }
    
    //
    // MARK: Content
    //
    
    internal func addBarButtons(toView view: UIView,
                                items: [TabmanBar.Item],
                                customize: TabmanButtonBarItemCustomize) {
        
        var previousButton: UIButton?
        for (index, item) in items.enumerated() {
            
            let button = UIButton()
            view.addSubview(button)
            
            if let image = item.image, let title = item.title {
                // resize images to fit
                let resizedImage = image.resize(toSize: Defaults.titleWithImageSize)
                if resizedImage.size != .zero {
                    button.setImage(resizedImage.withRenderingMode(imageRenderingMode), for: .normal)
                }
                button.setTitle(title, for: .normal)
                // Nudge it over a little bit
                button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 0.0)
            } else if let title = item.title {
                button.setTitle(title, for: .normal)
            } else if let image = item.image {
                // resize images to fit
                let resizedImage = image.resize(toSize: Defaults.itemImageSize)
                if resizedImage.size != .zero {
                    button.setImage(resizedImage.withRenderingMode(imageRenderingMode), for: .normal)
                }
            }
            
            // appearance
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.font = self.textFont
            
            // layout
            button.set(.height, to: Defaults.minimumItemHeight, priority: UILayoutPriority(500))
            button.pinToSuperviewEdge(.top)
            button.pinToSuperviewEdge(.bottom)
            
            let verticalPadding = self.itemVerticalPadding
            let insets = UIEdgeInsets(top: verticalPadding, left: 0.0, bottom: verticalPadding, right: 0.0)
            button.contentEdgeInsets = insets
            
            // Add horizontal pin constraints
            // These are breakable (For equal width instances etc.)
            if let previousButton = previousButton {
                horizontalMarginConstraints.append(button.pinEdge(.leading, to: .trailing, of: previousButton, priority: UILayoutPriority(500)))
            } else { // pin to leading
                self.edgeMarginConstraints.append(button.pinToSuperviewEdge(.leading, priority: UILayoutPriority(500)))
            }
            if index == items.count - 1 {
                self.edgeMarginConstraints.append(button.pinToSuperviewEdge(.trailing, priority: UILayoutPriority(500)))
            }
            
            // allow button to be compressed
            button.setContentCompressionResistance(for: .horizontal, to: UILayoutPriority(400))
            
            // Accessibility
            button.accessibilityLabel = item.accessibilityLabel
            button.accessibilityHint = item.accessibilityHint
            if let accessibilityTraits = item.accessibilityTraits {
                button.accessibilityTraits = accessibilityTraits
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
    
    internal func updateButtons(withContext context: ButtonContext = .all, update: (UIButton) -> Void) {
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
    
    @objc internal func tabButtonPressed(_ sender: UIButton) {
        if let index = self.buttons.index(of: sender), (self.responder?.bar(self, shouldSelectItemAt: index) ?? true) {
            isAnimatingFocussedButton = true
            responder?.bar(self, didSelectItemAt: index, completion: {
                self.isAnimatingFocussedButton = false
            })
        }
    }
    
    //
    // MARK: Layout
    //
    
    internal func updateConstraints(_ constraints: [NSLayoutConstraint], withValue value: CGFloat) {
        for constraint in constraints {
            var value = value
            if constraint.constant < 0.0 || constraint.firstAttribute == .trailing {
                value = -value
            }
            constraint.constant = value
        }
        self.layoutIfNeeded()
    }
}
