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

public class TabmanButtonBar: TabmanBar {
    
    private struct Defaults {
        static let edgeInset: CGFloat = 16.0
        static let horizontalSpacing: CGFloat = 20.0
    }
    
    private lazy var scrollView: TabmanScrollView = TabmanScrollView()
    private var buttons = [UIButton]()
    private var indicator = TabmanLineIndicator()
    
    private var horizontalMarginConstraints = [NSLayoutConstraint]()
    private var edgeMarginConstraints = [NSLayoutConstraint]()
    private var indicatorLeftMargin: NSLayoutConstraint?
    private var indicatorWidth: NSLayoutConstraint?
    
    public var edgeInset: CGFloat = Defaults.edgeInset {
        didSet {
            self.updateConstraints(self.edgeMarginConstraints,
                                   withValue: edgeInset)
        }
    }
    
    public var interItemSpacing: CGFloat = Defaults.horizontalSpacing {
        didSet {
            self.updateConstraints(self.horizontalMarginConstraints,
                                   withValue: interItemSpacing)
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
        
        self.buttons.removeAll()
        self.horizontalMarginConstraints.removeAll()
        self.edgeMarginConstraints.removeAll()
        
        // add buttons to view
        var previousButton: UIButton?
        for (index, item) in items.enumerated() {
            if let displayTitle = item.displayTitle {
                
                let button = UIButton(forAutoLayout: ())
                button.setTitle(displayTitle, for: .normal)
                
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
        
        var integral: Float = 0.0
        let transitionProgress = CGFloat(modff(Float(position), &integral))
        
        self.updateIndicator(forTransitionProgress: transitionProgress,
                             lowerButton: lowerButton,
                             upperButton: upperButton)
        
        self.scrollIndicatorPositionToVisible()
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
        
        let widthDiff = (upperButton.frame.size.width - lowerButton.frame.size.width) * progress
        let interpolatedWidth = lowerButton.frame.size.width + widthDiff
        self.indicatorWidth?.constant = interpolatedWidth
        
        let xDiff = (upperButton.frame.origin.x - lowerButton.frame.origin.x) * progress
        let interpolatedXOrigin = lowerButton.frame.origin.x + xDiff
        self.indicatorLeftMargin?.constant = interpolatedXOrigin
    }
    
    private func scrollIndicatorPositionToVisible() {
        
        let indicatorXOffset = self.indicatorLeftMargin?.constant ?? 0.0
        let indicatorWidthOffset = (self.bounds.size.width - (self.indicatorWidth?.constant ?? 0)) / 2.0
        let maxOffset = self.scrollView.contentSize.width - self.bounds.size.width
        
        guard indicatorWidthOffset > 0.0 else {
            return
        }
        
        let offset = max(0.0, min(maxOffset, indicatorXOffset - indicatorWidthOffset))
        
        self.scrollView.contentOffset = CGPoint(x: offset, y: 0.0)
    }
}
