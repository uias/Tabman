//
//  TabmanButtonBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout
import Pageboy

/// A tab bar with scrolling buttons and line indicator.
///
/// Akin to Android ViewPager, Instagram notification screen etc.
public class TabmanButtonBar: TabmanBar {
    
    //
    // MARK: Constants
    //
    
    private struct Defaults {
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
    
    private lazy var scrollView: TabmanScrollView = {
        let scrollView = TabmanScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private var buttons = [UIButton]()
    private var indicator = TabmanLineIndicator()
    
    private var horizontalMarginConstraints = [NSLayoutConstraint]()
    private var edgeMarginConstraints = [NSLayoutConstraint]()
    
    private var textFont: UIFont = Defaults.textFont
    private var textColor: UIColor = Defaults.textColor
    private var selectedTextColor: UIColor = Defaults.selectedTextColor
    
    private var currentTargetButton: UIButton? {
        didSet {
            guard currentTargetButton !== oldValue else { return }
            
            currentTargetButton?.setTitleColor(self.selectedTextColor, for: .normal)
            oldValue?.setTitleColor(self.textColor, for: .normal)
        }
    }
    
    // Public
    
    /// The inset at the edge of the bar items. (Default = 16.0)
    public var edgeInset: CGFloat = Defaults.edgeInset {
        didSet {
            self.updateConstraints(self.edgeMarginConstraints,
                                   withValue: edgeInset)
        }
    }
    
    /// The spacing between each bar item. (Default = 20.0)
    public var interItemSpacing: CGFloat = Defaults.horizontalSpacing {
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
    
    //
    // MARK: Lifecycle
    //
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.scrollIndicatorPositionToVisible()        
    }
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    override func constructTabBar(items: [TabmanBarItem]) {
        super.constructTabBar(items: items)
        
        // add scroll view
        self.containerView.addSubview(scrollView)
        scrollView.autoPinEdgesToSuperviewEdges()
        scrollView.match(parent: self, onDimension: .height)
        scrollView.contentView.removeAllSubviews()
        scrollView.isScrollEnabled = false
        
        self.buttons.removeAll()
        self.horizontalMarginConstraints.removeAll()
        self.edgeMarginConstraints.removeAll()
        
        // add buttons to view
        var previousButton: UIButton?
        for (index, item) in items.enumerated() {
            if let displayTitle = item.displayTitle {
                
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
        
        // add indicator
        self.scrollView.contentView.addSubview(self.indicator)
        self.indicator.autoPinEdge(toSuperviewEdge: .bottom)
        self.indicatorLeftMargin = self.indicator.autoPinEdge(toSuperviewEdge: .left)
        self.indicatorWidth = self.indicator.autoSetDimension(.width, toSize: 0.0)
        
        self.scrollView.layoutIfNeeded()
    }
    
    override func update(forPosition position: CGFloat,
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
        
        self.updateIndicator(forTransitionProgress: transitionProgress,
                             lowerButton: lowerButton,
                             upperButton: upperButton)
        self.updateButtons(withTargetButton: targetButton,
                           oldTargetButton: oldTargetButton,
                           progress: relativeProgress)
        self.scrollIndicatorPositionToVisible()
    }
    
    override func update(forAppearance appearance: TabmanBar.AppearanceConfig) {
        super.update(forAppearance: appearance)
        
        if let textColor = appearance.textColor {
            self.textColor = textColor
            self.updateButtons(withContext: .unselected, update: { button in
                button.setTitleColor(textColor, for: .normal)
                button.setTitleColor(textColor.withAlphaComponent(0.3), for: .highlighted)
            })
        }
        
        if let selectedTextColor = appearance.selectedTextColor {
            self.selectedTextColor = selectedTextColor
            self.currentTargetButton?.setTitleColor(selectedTextColor, for: .normal)
        }
        
        if let textFont = appearance.textFont {
            self.textFont = textFont
            self.updateButtons(update: { (button) in
                button.titleLabel?.font = textFont
            })
        }
        
        if let indicatorColor = appearance.indicator.color {
            self.indicator.tintColor = indicatorColor
        }
        
        if let isScrollEnabled = appearance.isScrollEnabled {
            self.scrollView.isScrollEnabled = isScrollEnabled
            UIView.animate(withDuration: 0.3, animations: { // reset scroll position
                self.scrollIndicatorPositionToVisible()
            })
        }
        
        if let interItemSpacing = appearance.interItemSpacing {
            self.interItemSpacing = interItemSpacing
        }
        
        if let edgeInset = appearance.edgeInset {
            self.edgeInset = edgeInset
        }
        
        if let indicatorIsProgressive = appearance.indicator.isProgressive {
            self.indicatorLeftMargin?.constant = indicatorIsProgressive ? 0.0 : self.edgeInset
            UIView.animate(withDuration: 0.3, animations: {
                self.update(forPosition: self.currentPosition,
                            direction: .neutral,
                            minimumIndex: Int(floor(self.currentPosition)),
                            maximumIndex: Int(ceil(self.currentPosition)))
            })
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
    
    private func updateIndicator(forTransitionProgress progress: CGFloat,
                                 lowerButton: UIButton,
                                 upperButton: UIButton) {
        
        if self.indicatorIsProgressive {
            
            let indicatorStartFrame = lowerButton.frame.origin.x + lowerButton.frame.size.width
            let indicatorEndFrame = upperButton.frame.origin.x + upperButton.frame.size.width
            let endFrameDiff = indicatorEndFrame - indicatorStartFrame
            
            self.indicatorWidth?.constant = indicatorStartFrame + (endFrameDiff * progress)
            
        } else {
            
            let widthDiff = (upperButton.frame.size.width - lowerButton.frame.size.width) * progress
            let interpolatedWidth = lowerButton.frame.size.width + widthDiff
            self.indicatorWidth?.constant = interpolatedWidth
            
            let xDiff = (upperButton.frame.origin.x - lowerButton.frame.origin.x) * progress
            let interpolatedXOrigin = lowerButton.frame.origin.x + xDiff
            self.indicatorLeftMargin?.constant = interpolatedXOrigin
        }
    }
    
    private func updateButtons(withTargetButton targetButton: UIButton,
                               oldTargetButton: UIButton,
                               progress: CGFloat) {
        guard targetButton !== oldTargetButton else {
            self.currentTargetButton = targetButton
            return
        }
        
        targetButton.setTitleColor(UIColor.interpolate(betweenColor: self.textColor,
                                                       and: self.selectedTextColor,
                                                       percent: progress), for: .normal)
        oldTargetButton.setTitleColor(UIColor.interpolate(betweenColor: self.textColor,
                                                          and: self.selectedTextColor,
                                                          percent: 1.0 - progress), for: .normal)
    }
    
    private func scrollIndicatorPositionToVisible() {
        var offset: CGFloat = 0.0
        let maxOffset = self.scrollView.contentSize.width - self.bounds.size.width

        
        if self.indicatorIsProgressive {
            
            let index = Int(ceil(self.currentPosition))
            let buttonFrame = self.buttons[index].frame
            offset = ((indicatorWidth?.constant ?? 0.0) - (self.bounds.size.width / 2.0)) - (buttonFrame.size.width / 2.0)
            
        } else {
            
            let indicatorXOffset = self.indicatorLeftMargin?.constant ?? 0.0
            let indicatorWidthOffset = (self.bounds.size.width - (self.indicatorWidth?.constant ?? 0)) / 2.0
            
            guard indicatorWidthOffset > 0.0 else {
                return
            }
            
            offset = indicatorXOffset - indicatorWidthOffset
        }
        
        offset = max(0.0, min(maxOffset, offset))
        self.scrollView.contentOffset = CGPoint(x: offset, y: 0.0)
    }
    
    //
    // MARK: Actions
    //
    
    func tabButtonPressed(_ sender: UIButton) {
        if let index = self.buttons.index(of: sender) {
            self.delegate?.tabBar(self, didSelectTabAtIndex: index)
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
