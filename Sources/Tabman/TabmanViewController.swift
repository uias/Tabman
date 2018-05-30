//
//  TabmanViewController.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy
import AutoInsetter

/// Page view controller with a bar indicator component.
open class TabmanViewController: PageboyViewController, PageboyViewControllerDelegate {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let bar = BarView<ButtonBarLayout>()
    }
    
    // MARK: PageboyViewControllerDelegate
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    willScrollToPageAt index: PageIndex,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollTo position: CGPoint,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didScrollToPageAt index: PageIndex,
                                    direction: NavigationDirection,
                                    animated: Bool) {
        
    }
    
    open func pageboyViewController(_ pageboyViewController: PageboyViewController,
                                    didReloadWith currentViewController: UIViewController,
                                    currentPageIndex: PageIndex) {
        
    }
}
