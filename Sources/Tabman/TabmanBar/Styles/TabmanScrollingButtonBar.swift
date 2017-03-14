//
//  TabmanScrollingButtonBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout
import Pageboy

/// A bar with scrolling buttons and line indicator.
///
/// Akin to Android ViewPager, Instagram notification screen etc.
public class TabmanScrollingButtonBar: TabmanBar {
        
    //
    // MARK: Constants
    //
    
    private struct Defaults {
        static let height: CGFloat = 42.0
        static let indicatorHeight: CGFloat = 2.0
        
        static let edgeInset: CGFloat = 16.0
        static let horizontalSpacing: CGFloat = 20.0
        
        static let textFont: UIFont = UIFont.systemFont(ofSize: 16.0)
        static let selectedTextColor: UIColor = .black
        static let textColor: UIColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    //
    // MARK: Properties
    //
    
    // Private
    
    internal lazy var scrollView: TabmanScrollView = {
        let scrollView = TabmanScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    internal var buttons = [UIButton]()
    
    private var horizontalMarginConstraints = [NSLayoutConstraint]()
    private var edgeMarginConstraints = [NSLayoutConstraint]()
    
    private var textFont: UIFont = Appearance.defaultAppearance.text.font ?? Defaults.textFont
    private var textColor: UIColor = Appearance.defaultAppearance.state.color ?? Defaults.textColor
    private var selectedTextColor: UIColor = Appearance.defaultAppearance.state.selectedColor ?? Defaults.selectedTextColor
    
    private var currentTargetButton: UIButton? {
        didSet {
            guard currentTargetButton !== oldValue else { return }
            
            currentTargetButton?.setTitleColor(self.selectedTextColor, for: .normal)
            oldValue?.setTitleColor(self.textColor, for: .normal)
        }
    }
    
    // Public
    
    /// The inset at the edge of the bar items. (Default = 16.0)
    public var edgeInset: CGFloat = Appearance.defaultAppearance.layout.edgeInset ?? Defaults.edgeInset {
        didSet {
            self.updateConstraints(self.edgeMarginConstraints,
                                   withValue: edgeInset)
        }
    }
    
    /// The spacing between each bar item. (Default = 20.0)
    public var interItemSpacing: CGFloat = Appearance.defaultAppearance.layout.interItemSpacing ?? Defaults.horizontalSpacing {
        didSet {
            self.updateConstraints(self.horizontalMarginConstraints,
                                   withValue: interItemSpacing)
        }
    }
    
    /// Whether scroll is enabled on the bar.
    public var isScrollEnabled: Bool {
        set(isScrollEnabled) {
            self.scrollView.isScrollEnabled = isScrollEnabled
        }
        get {
            return self.scrollView.isScrollEnabled
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: Defaults.height + (self.indicator?.intrinsicContentSize.height ?? Defaults.indicatorHeight))
    }
    
    //
    // MARK: Lifecycle
    //
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.transitionHandler?.indicatorTransition(forBar: self)?.updateForCurrentPosition()
    }
    
    public override func defaultIndicatorStyle() -> TabmanIndicator.Style {
        return .line
    }
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    override public func constructTabBar(items: [TabmanBarItem]) {
        super.constructTabBar(items: items)
        
        // add scroll view
        self.contentView.addSubview(scrollView)
        scrollView.autoPinEdgesToSuperviewEdges()
        scrollView.match(parent: self, onDimension: .height)
        scrollView.contentView.removeAllSubviews()
        scrollView.isScrollEnabled = self.appearance.interaction.isScrollEnabled ?? false
        
        self.buttons.removeAll()
        self.horizontalMarginConstraints.removeAll()
        self.edgeMarginConstraints.removeAll()
        
        // add buttons to view
        var previousButton: UIButton?
        for (index, item) in items.enumerated() {
            if let displayTitle = item.title {
                
                // configure button
                let button = UIButton(forAutoLayout: ())
                button.setTitle(displayTitle, for: .normal)
                button.setTitleColor(self.textColor, for: .normal)
                button.setTitleColor(self.textColor.withAlphaComponent(0.3), for: .highlighted)
                button.titleLabel?.font = self.textFont
                button.addTarget(self, action: #selector(tabButtonPressed(_:)), for: .touchUpInside)
                
                self.scrollView.contentView.addSubview(button)
                button.autoAlignAxis(toSuperviewAxis: .horizontal)
                
                if previousButton == nil { // pin to left
                    self.edgeMarginConstraints.append(button.autoPinEdge(toSuperviewEdge: .left,
                                                                         withInset: self.edgeInset))
                } else {
                    self.horizontalMarginConstraints.append(button.autoPinEdge(.left, to: .right,
                                                                               of: previousButton!,
                                                                               withOffset: self.interItemSpacing))
                    if index == items.count - 1 {
                        self.edgeMarginConstraints.append(button.autoPinEdge(toSuperviewEdge: .right,
                                                                             withInset: self.edgeInset))
                    }
                }
                
                self.buttons.append(button)
                previousButton = button
            }
        }
        
        self.scrollView.layoutIfNeeded()
    }
    
    public override func addIndicatorToBar(indicator: TabmanIndicator) {
        super.addIndicatorToBar(indicator: indicator)
        
        self.scrollView.contentView.addSubview(indicator)
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
        
        let (lowerIndex, upperIndex) = self.lowerAndUpperIndex(forPosition: position,
                                                               minimum: minimumIndex,
                                                               maximum: maximumIndex)
        let lowerButton = self.buttons[lowerIndex]
        let upperButton = self.buttons[upperIndex]
        
        let targetButton = direction == .forward ? upperButton : lowerButton
        let oldTargetButton = direction == .forward ? lowerButton : upperButton
        
        var integral: Float = 0.0
        let transitionProgress = CGFloat(modff(Float(position), &integral))
        
        let relativeProgress = direction == .forward ? transitionProgress : 1.0 - transitionProgress
        
        self.updateButtons(withTargetButton: targetButton,
                           oldTargetButton: oldTargetButton,
                           progress: relativeProgress)
    }
    
    override public func update(forAppearance appearance: TabmanBar.Appearance) {
        super.update(forAppearance: appearance)
        
        if let textColor = appearance.state.color {
            self.textColor = textColor
            self.updateButtons(withContext: .unselected, update: { button in
                button.setTitleColor(textColor, for: .normal)
                button.setTitleColor(textColor.withAlphaComponent(0.3), for: .highlighted)
            })
        }
        
        if let selectedTextColor = appearance.state.selectedColor {
            self.selectedTextColor = selectedTextColor
            self.currentTargetButton?.setTitleColor(selectedTextColor, for: .normal)
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
        
        if let isScrollEnabled = appearance.interaction.isScrollEnabled {
            self.scrollView.isScrollEnabled = isScrollEnabled
            UIView.animate(withDuration: 0.3, animations: { // reset scroll position
                self.transitionHandler?.indicatorTransition(forBar: self)?.updateForCurrentPosition()
            })
        }
        
        if let interItemSpacing = appearance.layout.interItemSpacing {
            self.interItemSpacing = interItemSpacing
        }
        
        if let edgeInset = appearance.layout.edgeInset {
            self.edgeInset = edgeInset
            self.updateForCurrentPosition()
        }
        
        if let indicatorIsProgressive = appearance.indicator.isProgressive {
            self.indicatorLeftMargin?.constant = indicatorIsProgressive ? 0.0 : self.edgeInset
            UIView.animate(withDuration: 0.3, animations: {
                self.updateForCurrentPosition()
            })
        }
        
        if let indicatorWeight = appearance.indicator.lineWeight,
            let lineIndicator = self.indicator as? TabmanLineIndicator {
            lineIndicator.weight = indicatorWeight
        }
    }
    
    //
    // MARK: Layout
    //
    
    private func updateConstraints(_ constraints: [NSLayoutConstraint], withValue value: CGFloat) {
        for constraint in constraints {
            var value = value
            if constraint.constant < 0.0 {
                value = -value
            }
            constraint.constant = value
        }
        self.layoutIfNeeded()
    }
    
    private func updateButtons(withTargetButton targetButton: UIButton,
                               oldTargetButton: UIButton,
                               progress: CGFloat) {
        guard targetButton !== oldTargetButton else {
            self.currentTargetButton = targetButton
            return
        }
        
        let targetColor = UIColor.interpolate(betweenColor: self.textColor,
                                              and: self.selectedTextColor,
                                              percent: progress)
        let oldTargetColor = UIColor.interpolate(betweenColor: self.textColor,
                                                 and: self.selectedTextColor,
                                                 percent: 1.0 - progress)
        
        targetButton.tintColor = targetColor
        targetButton.setTitleColor(targetColor, for: .normal)
        oldTargetButton.tintColor = oldTargetColor
        oldTargetButton.setTitleColor(oldTargetColor, for: .normal)
    }
    
    //
    // MARK: Actions
    //
    
    func tabButtonPressed(_ sender: UIButton) {
        if let index = self.buttons.index(of: sender) {
            self.delegate?.bar(self, didSelectItemAtIndex: index)
        }
    }
    
    //
    // MARK: Utilities
    //
    
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
