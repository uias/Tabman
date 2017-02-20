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
    internal var containerView: UIView!
    
    //
    // MARK: Properties
    //
    
    public var dataSource: TabmanBarDataSource? {
        didSet {
            self.reloadData()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 44.0)
    }
    
    //
    // MARK: Init
    //
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initTabBar()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initTabBar()
    }
    
    private func initTabBar() {
                
        let containerView = UIView()
        self.addSubview(containerView)
        containerView.autoPinEdgesToSuperviewEdges()
        containerView.backgroundColor = .green
        self.containerView = containerView
    }
    
    //
    // MARK: Data
    //
    
    public func reloadData() {
        self.items = self.dataSource?.items(forTabBar: self)
        guard self.items != nil else {
            return
        }
        
        self.clearAndConstructTabBar()
    }
    
    private func clearAndConstructTabBar() {
        self.clearTabBar()
        self.constructTabBar()
    }
}

internal extension TabmanBar {

    func clearTabBar() {
        for subview in self.containerView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func constructTabBar() {
        
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
