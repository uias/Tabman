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
        static let horizontalSpacing: CGFloat = 16.0
    }
    
    private lazy var scrollView = UIScrollView()
    
    private var buttons = [UIButton]()
    private var horizontalMarginConstraints = [NSLayoutConstraint]()
    
    public var horizontalSpacing: CGFloat = Defaults.horizontalSpacing {
        didSet {
            self.updateHorizontalSpacing(spacing: horizontalSpacing)
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
        
        // add buttons to view
        var previousButton: UIButton?
        for (index, item) in items.enumerated() {
            if let displayTitle = item.displayTitle {
                
                let button = UIButton(forAutoLayout: ())
                button.setTitle(displayTitle, for: .normal)
                
                self.scrollView.addSubview(button)
                button.autoAlignAxis(toSuperviewAxis: .horizontal)
                
                if previousButton == nil { // pin to left
                    self.horizontalMarginConstraints.append(button.autoPinEdge(toSuperviewEdge: .left))
                } else {
                    self.horizontalMarginConstraints.append(button.autoPinEdge(.left, to: .right, of: previousButton!))
                    if index == items.count - 1 {
                        self.horizontalMarginConstraints.append(button.autoPinEdge(toSuperviewEdge: .right))
                    }
                }
                
                self.buttons.append(button)
                previousButton = button
            }
        }
        
        self.updateHorizontalSpacing(spacing: self.horizontalSpacing)
    }
    
    //
    // MARK: Layout
    //
    
    private func updateHorizontalSpacing(spacing: CGFloat) {
        for constraint in self.horizontalMarginConstraints {
            constraint.constant = spacing
        }
        self.layoutIfNeeded()
    }
}
