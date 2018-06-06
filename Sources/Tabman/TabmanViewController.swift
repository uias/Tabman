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
import SnapKit

/// Page view controller with a bar indicator component.
open class TabmanViewController: PageboyViewController, PageboyViewControllerDelegate {
    
    // MARK: Properties
    
    public let bar = BarView<ButtonBarLayout, LabelBarButton>()
    
    // MARK: Init
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        delegate = self
    }
    
    // MARK: Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bar)
        bar.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
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
