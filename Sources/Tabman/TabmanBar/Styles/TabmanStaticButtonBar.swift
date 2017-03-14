//
//  TabmanButtonBar.swift
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
public class TabmanStaticButtonBar: TabmanButtonBar {
    
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
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 50.0)
    }
    
    //
    // MARK: Lifecycle
    //
    
    override public func defaultIndicatorStyle() -> TabmanIndicator.Style {
        return .custom(type: TabmanBlockIndicator.self)
    }
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    override public func constructTabBar(items: [TabmanBarItem]) {
        super.constructTabBar(items: items)
        
        self.buttons.removeAll()
        
        let buttonContentView = UIView(forAutoLayout: ())
        let maskContentView = UIView(forAutoLayout: ())
        maskContentView.isUserInteractionEnabled = false
        
        self.contentView.addSubview(buttonContentView)
        buttonContentView.autoPinEdgesToSuperviewEdges()
        self.contentView.addSubview(maskContentView)
        maskContentView.autoPinEdgesToSuperviewEdges()
        maskContentView.mask = self.indicatorMaskView
        
        self.addBarButtons(toView: buttonContentView, items: items) { (button) in
            let color = self.appearance.state.color ?? Defaults.color
            button.tintColor = color
            button.setTitleColor(color, for: .normal)
            button.setTitleColor(color.withAlphaComponent(0.3), for: .highlighted)

            self.buttons.append(button)
            button.addTarget(self, action: #selector(tabButtonPressed(_:)), for: .touchUpInside)
        }
        self.addBarButtons(toView: maskContentView, items: items) { (button) in
            let selectedColor = self.appearance.state.selectedColor ?? Defaults.selectedColor
            button.tintColor = selectedColor
            button.setTitleColor(selectedColor, for: .normal)
        }
        
        self.buttonContentView = buttonContentView
        self.maskContentView = maskContentView
    }
    
    override public func addIndicatorToBar(indicator: TabmanIndicator) {
        super.addIndicatorToBar(indicator: indicator)
        
        self.contentView.addSubview(indicator)
        indicator.autoPinEdge(toSuperviewEdge: .bottom)
        self.indicatorLeftMargin = indicator.autoPinEdge(toSuperviewEdge: .left)
        self.indicatorWidth = indicator.autoSetDimension(.width, toSize: 0.0)
    }
    
    override public func update(forPosition position: CGFloat,
                                direction: PageboyViewController.NavigationDirection,
                                minimumIndex: Int,
                                maximumIndex: Int) {
        super.update(forPosition: position,
                     direction: direction,
                     minimumIndex: minimumIndex,
                     maximumIndex: maximumIndex)
        
        self.contentView.layoutIfNeeded()
        self.indicatorMaskView.frame = self.indicator?.frame ?? .zero
    }

    override func update(forAppearance appearance: TabmanBar.Appearance) {
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
        
        if let indicatorColor = appearance.indicator.color {
            self.indicator?.tintColor = indicatorColor
        }
    }
    
    //
    // MARK: Button Manipulation
    //
    
    private func addBarButtons(toView view: UIView,
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
