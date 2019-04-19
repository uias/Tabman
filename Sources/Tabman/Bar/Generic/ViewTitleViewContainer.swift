//
//  ViewTitleViewContainer.swift
//  Tabman
//
//  Created by Merrick Sapsford on 23/03/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

/// View which provides the necessary container utilities for setting a view
/// as a `UINavigationItem.titleView`.
class ViewTitleViewContainer: UIView {
    
    // MARK: Properties
    
    override var intrinsicContentSize: CGSize {
        #if swift(>=4.2)
        return UIView.layoutFittingExpandedSize
        #else
        return UILayoutFittingExpandedSize
        #endif
    }
    
    // MARK: Init
    
    init(for view: UIView) {
        super.init(frame: .zero)
        
        layout(view: view, in: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Layout
    
    private func layout(view: UIView, in container: UIView) {
        container.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            view.topAnchor.constraint(equalTo: container.topAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
