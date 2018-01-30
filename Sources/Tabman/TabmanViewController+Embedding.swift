//
//  TabmanViewController+Embedding.swift
//  Tabman
//
//  Created by Merrick Sapsford on 03/04/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

// MARK: - External TabmanBar attach/detachment.
public extension TabmanViewController {
    
    /// Attach a TabmanBar that is somewhere in the view hierarchy.
    /// This will replace the TabmanViewController managed instance.
    ///
    /// - Parameter bar: The bar to attach.
    public func attach(bar: TabmanBar) {
        guard self.attachedTabmanBar == nil else {
            fatalError("Tabman - You must detach the currently attached bar before attempting to attach a new bar.")
        }
        
        self.tabmanBar?.isHidden = true
        setNeedsChildAutoInsetUpdate()
        
        // hook up new bar
        bar.dataSource = self
        bar.responder = self
        bar.transitionStore = self.barTransitionStore
        if let appearance = self.bar.appearance {
            bar.appearance = appearance
        }
        bar.isHidden = true
        self.attachedTabmanBar = bar
        
        bar.reloadData()
    }
    
    /// Detach a currently attached external TabmanBar.
    /// This will reinstate the TabmanViewController managed instance.
    ///
    /// - Returns: The detached bar.
    @discardableResult public func detachAttachedBar() -> TabmanBar? {
        guard let bar = self.attachedTabmanBar, self.attachedTabmanBar === bar else {
            return nil
        }
        
        bar.dataSource = nil
        bar.responder = nil
        bar.transitionStore = nil
        bar.isHidden = false
        self.attachedTabmanBar = nil
        
        self.tabmanBar?.reloadData()
        self.view.layoutIfNeeded()
        
        setNeedsChildAutoInsetUpdate()
        
        return bar
    }
    
}

// MARK: - Internal TabmanBar embedding in external view.
public extension TabmanViewController {
    
    /// Embed the TabmanBar in an external view.
    /// This will add the bar to the specified view, and pin the bar edges to the view edges.
    ///
    /// - Parameter view: The view to embed the bar in.
    @available(*, deprecated: 1.0.4, message: "Use embedBar(in: )")
    public func embedBar(inView view: UIView) {
        embedBar(in: view)
    }
    
    /// Embed the TabmanBar in an external view.
    /// This will add the bar to the specified view, and pin the bar edges to the view edges.
    ///
    /// - Parameter view: The view to embed the bar in.
    public func embedBar(in view: UIView) {
        guard let bar = self.tabmanBar else {
            return
        }
        guard self.embeddingView == nil || view === self.embeddingView else {
            fatalError("Tabman - The bar must be disembedded from the view it is currently embedded in first. Use disembedBar().")
        }
        
        self.embeddingView = view
        
        bar.removeFromSuperview()
        view.addSubview(bar)
        bar.pinToSuperviewEdges()
        setNeedsChildAutoInsetUpdate()
        
        view.layoutIfNeeded()
    }
    
    /// Disembed the TabmanBar from an external view if it is currently embedded.
    public func disembedBar() {
        guard let bar = self.tabmanBar, self.embeddingView != nil else {
            return
        }
        
        bar.removeFromSuperview()
        self.embeddingView = nil
        
        self.updateBar(withLocation: self.bar.location)
    }
}
