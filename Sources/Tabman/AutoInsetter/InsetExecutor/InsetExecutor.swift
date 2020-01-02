//
//  InsetExecutor.swift
//  AutoInsetter
//
//  Created by Merrick Sapsford on 16/03/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

@available(iOS, deprecated: 11)
internal class InsetExecutor {
    
    let view: UIScrollView
    let calculator: InsetCalculator
    let spec: AutoInsetSpec
    
    init(view: UIScrollView, calculator: InsetCalculator, spec: AutoInsetSpec) {
        self.view = view
        self.calculator = calculator
        self.spec = spec
    }
    
    func execute(store: InsetStore) {
        
        // If content inset has changed
        if let contentInset = calculator.calculateContentInset(from: spec, store: store) {
            view.contentInset = contentInset.new
            invalidateLayoutIfNeeded()

            // If content offset has changed
            if let contentOffset = calculator.calculateContentOffset(from: contentInset, store: store) {
                view.contentOffset = contentOffset.new
            }
        }
        
        // If indicator insets have changed.
        if let scrollIndicatorInsets = calculator.calculateScrollIndicatorInsets(from: spec) {
            view.scrollIndicatorInsets = scrollIndicatorInsets
        }
    }
    
    private func invalidateLayoutIfNeeded() {
        (view as? UICollectionView)?.collectionViewLayout.invalidateLayout()
    }
}
