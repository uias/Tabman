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
    
    private lazy var scrollView = UIScrollView()
    
    // MARK: TabmanBar Lifecycle
        
    override func constructTabBar() {
        super.constructTabBar()
        
//        self.containerView.addSubview(scrollView)
//        scrollView.edges(to: containerView)
//        scrollView.backgroundColor = .blue
    }
}
