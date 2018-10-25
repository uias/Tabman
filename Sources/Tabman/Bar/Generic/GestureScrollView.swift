//
//  GestureScrollView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 25/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal final class GestureScrollView: UIScrollView {
    
    enum ScrollMode {
        case interactive
        case gesture
        case none
    }
    
    @available(*, unavailable)
    override var isScrollEnabled: Bool {
        didSet {}
    }
    
    var scrollMode: ScrollMode = .interactive {
        didSet {
            update(for: scrollMode)
        }
    }
    
    private func update(for scrollMode: ScrollMode) {
        switch scrollMode {
        case .interactive:
            super.isScrollEnabled = true
        case .gesture:
            fatalError()
        case .none:
            super.isScrollEnabled = false
        }
    }
}
