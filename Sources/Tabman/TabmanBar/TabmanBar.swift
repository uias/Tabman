//
//  TabmanBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout

public protocol TabmanBarDataSource {
    
    func items(forTabBar tabBar: TabmanBar) -> [TabmanBarItem]?
}

public class TabmanBar: UIView {
    
    //
    // MARK: Types
    //
    
    public enum Style {
        case buttonBar
        case progressiveBar
        case segmented
    }
    
    public enum Location {
        case top
        case bottom
    }
    
    //
    // MARK: Variables
    //
    
    internal var items: [TabmanBarItem]?
    internal var containerView = UIView(forAutoLayout: ())
    
    //
    // MARK: Properties
    //
    
    public var dataSource: TabmanBarDataSource? {
        didSet {
            self.reloadData()
        }
    }
    
    internal var position: CGFloat = 0.0 {
        didSet {
            guard let items = self.items else {
                return
            }
            
            self.update(forPosition: position,
                        min: 0.0, max: CGFloat(items.count - 1))
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 44.0)
    }
    
    //
    // MARK: Init
    //
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initTabBar()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initTabBar()
    }
    
    private func initTabBar() {
        
        self.addSubview(containerView)
        containerView.autoPinEdgesToSuperviewEdges()
    }
    
    //
    // MARK: Data
    //
    
    public func reloadData() {
        self.items = self.dataSource?.items(forTabBar: self)
        self.clearAndConstructTabBar()
    }
    
    private func clearAndConstructTabBar() {
        guard let items = self.items else { return } // no items yet
        
        self.clearTabBar()
        self.constructTabBar(items: items)
    }
    
    //
    // MARK: TabBar content
    //
    
    func clearTabBar() {
        for subview in containerView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func constructTabBar(items: [TabmanBarItem]) {
        
    }
    
    func update(forPosition position: CGFloat, min: CGFloat, max: CGFloat) {
        
    }
}

internal extension TabmanBar.Style {
    
    var rawType: TabmanBar.Type? {
        switch self {
            
        case .buttonBar:
            return TabmanButtonBar.self
            
        default:()
        }
        return nil
    }
    
}
