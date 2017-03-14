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
public class TabmanScrollingButtonBar: TabmanButtonBar {
        
    //
    // MARK: Constants
    //
    
    private struct Defaults {
        static let height: CGFloat = 42.0
        static let indicatorHeight: CGFloat = 2.0
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
       
    // Public
    
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
        
        self.addBarButtons(toView: self.scrollView.contentView, items: items)
        { (button, previousButton) in
            self.buttons.append(button)
            
            button.setTitleColor(self.color, for: .normal)
            button.setTitleColor(self.color.withAlphaComponent(0.3), for: .highlighted)
            button.titleLabel?.font = self.textFont
            button.addTarget(self, action: #selector(tabButtonPressed(_:)), for: .touchUpInside)
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
    
    override public func update(forAppearance appearance: TabmanBar.Appearance) {
        super.update(forAppearance: appearance)
        
        
        
        if let isScrollEnabled = appearance.interaction.isScrollEnabled {
            self.scrollView.isScrollEnabled = isScrollEnabled
            UIView.animate(withDuration: 0.3, animations: { // reset scroll position
                self.transitionHandler?.indicatorTransition(forBar: self)?.updateForCurrentPosition()
            })
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
