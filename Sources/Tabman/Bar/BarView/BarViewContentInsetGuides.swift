//
//  BarViewLayoutGuides.swift
//  Tabman
//
//  Created by Merrick Sapsford on 01/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal final class BarViewContentInsetGuides {
    
    // MARK: Properties
    
    /// Layout Guide for the leading inset on the bar.
    public let leading: UILayoutGuide = {
        let guide = UILayoutGuide()
        guide.identifier = "barInsetsLeadingGuide"
        return guide
    }()
    private let leadingWidth: NSLayoutConstraint
    
    /// Layout Guide for the trailing inset on the bar.
    public let trailing: UILayoutGuide = {
        let guide = UILayoutGuide()
        guide.identifier = "barInsetsTrailingGuide"
        return guide
    }()
    private let trailingWidth: NSLayoutConstraint
    
    /// Layout Guide for the content (middle) inside the two insets on the bar.
    public let content: UILayoutGuide = {
        let guide = UILayoutGuide()
        guide.identifier = "barInsetsContentGuide"
        return guide
    }()
    
    /// The content inset currently applied to the bar.
    internal var contentInset: UIEdgeInsets = .zero {
        didSet {
            leadingWidth.constant = contentInset.left
            trailingWidth.constant = contentInset.right
        }
    }
    
    // MARK: Init
    
    init<LayoutType, ButtonType>(for barView: BarView<LayoutType, ButtonType>) {
        barView.addLayoutGuide(leading)
        barView.addLayoutGuide(content)
        barView.addLayoutGuide(trailing)
        
        leading.leadingAnchor.constraint(equalTo: barView.leadingAnchor).isActive = true
        leading.topAnchor.constraint(equalTo: barView.topAnchor).isActive = true
        
        content.leadingAnchor.constraint(equalTo: leading.trailingAnchor).isActive = true
        content.topAnchor.constraint(equalTo: barView.topAnchor).isActive = true
        content.trailingAnchor.constraint(equalTo: trailing.leadingAnchor).isActive = true
        
        trailing.trailingAnchor.constraint(equalTo: barView.trailingAnchor).isActive = true
        trailing.topAnchor.constraint(equalTo: barView.topAnchor).isActive = true
        
        self.leadingWidth = leading.widthAnchor.constraint(equalToConstant: contentInset.left)
        self.trailingWidth = trailing.widthAnchor.constraint(equalToConstant: contentInset.right)
        
        leadingWidth.isActive = true
        trailingWidth.isActive = true
    }
}
