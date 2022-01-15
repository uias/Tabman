//
//  TMBarViewScrollHandler.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/10/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

internal protocol TMBarViewScrollHandlerDelegate: AnyObject {
    
    func barViewScrollHandler(_ handler: TMBarViewScrollHandler,
                              didReceiveUpdated contentOffset: CGPoint,
                              from scrollView: UIScrollView)
}

/// Handler which interprets raw `UIScrollViewDelegate` events and provides updates via `TMBarViewScrollHandlerDelegate`.
internal final class TMBarViewScrollHandler: NSObject {
    
    weak var delegate: TMBarViewScrollHandlerDelegate?
    
    init(for scrollView: UIScrollView) {
        super.init()
        scrollView.delegate = self
    }
}

extension TMBarViewScrollHandler: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.barViewScrollHandler(self, didReceiveUpdated: scrollView.contentOffset, from: scrollView)
    }
}
