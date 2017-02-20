//
//  TabmanButtonBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout

public class TabmanButtonBar: TabmanBar {
    
    private struct Defaults {
        static let edgeInset: CGFloat = 16.0
        static let horizontalSpacing: CGFloat = 20.0
    }
    
    private lazy var scrollView = UIScrollView()
    private var buttons = [UIButton]()
    
    private var horizontalMarginConstraints = [NSLayoutConstraint]()
    private var edgeMarginConstraints = [NSLayoutConstraint]()

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
    // MARK: TabmanBar Lifecycle
    //
    
    override func constructTabBar(items: [TabmanBarItem]) {
        super.constructTabBar(items: items)
        
        // add scroll view
        self.containerView.addSubview(scrollView)
        scrollView.autoPinEdgesToSuperviewEdges()
        
        self.buttons.removeAll()
        self.horizontalMarginConstraints.removeAll()
        self.edgeMarginConstraints.removeAll()
        
        // add buttons to view
        var previousButton: UIButton?
        for (index, item) in items.enumerated() {
            if let displayTitle = item.displayTitle {
                
                let button = UIButton(forAutoLayout: ())
                button.setTitle(displayTitle, for: .normal)
                
                self.scrollView.addSubview(button)
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
}
