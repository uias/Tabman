//
//  BarViewLayoutGuides.swift
//  Tabman
//
//  Created by Merrick Sapsford on 01/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public final class BarViewLayoutReferences {
    
    // MARK: Properties
    
    private(set) weak var rootView: UIView!
    private(set) weak var scrollView: UIScrollView!
    private(set) weak var contentView: UIView!
    
    // MARK: Init
    
    init(rootView: UIView,
         scrollView: UIScrollView,
         contentView: UIView) {
        self.rootView = rootView
        self.scrollView = scrollView
        self.contentView = contentView
    }
}
