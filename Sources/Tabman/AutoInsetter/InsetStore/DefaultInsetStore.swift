//
//  DefaultInsetStore.swift
//  AutoInsetter
//
//  Created by Merrick Sapsford on 19/03/2019.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

internal final class DefaultInsetStore: InsetStore {
    
    // MARK: Properties
    
    private var contentInsets = [UIScrollView: UIEdgeInsets]()
    private var contentOffsets = [UIScrollView: CGPoint]()
    
    // MARK: InsetStore
    
    func store(contentInset: UIEdgeInsets, for view: UIScrollView) {
        contentInsets[view] = contentInset
    }
    
    func store(contentOffset: CGPoint, for view: UIScrollView) {
        contentOffsets[view] = contentOffset
    }
    
    func contentInset(for view: UIScrollView) -> UIEdgeInsets? {
        return contentInsets[view]
    }
    
    func contentOffset(for view: UIScrollView) -> CGPoint? {
        return contentOffsets[view]
    }
}
