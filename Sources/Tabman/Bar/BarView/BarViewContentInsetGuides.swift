//
//  BarViewLayoutGuides.swift
//  Tabman
//
//  Created by Merrick Sapsford on 01/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal final class BarViewContentInsetGuides: BarLayoutInsetGuides {
    
    // MARK: Properties
    
    /// Layout Guide for the leading inset on the bar.
    public let leadingInset: UILayoutGuide = {
        let guide = UILayoutGuide()
        guide.identifier = "barInsetsLeadingGuide"
        return guide
    }()
    private let leadingWidth: NSLayoutConstraint
    
    /// Layout Guide for the trailing inset on the bar.
    public let trailingInset: UILayoutGuide = {
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
    internal var insets: UIEdgeInsets = .zero {
        didSet {
            leadingWidth.constant = insets.left
            trailingWidth.constant = insets.right
        }
    }
    
    // MARK: Init
    
    init<LayoutType, ButtonType, IndicatorType>(for barView: BarView<LayoutType, ButtonType, IndicatorType>) {
        barView.addLayoutGuide(leadingInset)
        barView.addLayoutGuide(content)
        barView.addLayoutGuide(trailingInset)
        
        leadingInset.leadingAnchor.constraint(equalTo: barView.leadingAnchor).isActive = true
        leadingInset.topAnchor.constraint(equalTo: barView.topAnchor).isActive = true
        
        content.leadingAnchor.constraint(equalTo: leadingInset.trailingAnchor).isActive = true
        content.topAnchor.constraint(equalTo: barView.topAnchor).isActive = true
        content.trailingAnchor.constraint(equalTo: trailingInset.leadingAnchor).isActive = true
        
        trailingInset.trailingAnchor.constraint(equalTo: barView.trailingAnchor).isActive = true
        trailingInset.topAnchor.constraint(equalTo: barView.topAnchor).isActive = true
        
        self.leadingWidth = trailingInset.widthAnchor.constraint(equalToConstant: insets.left)
        self.trailingWidth = trailingInset.widthAnchor.constraint(equalToConstant: insets.right)
        
        leadingWidth.isActive = true
        trailingWidth.isActive = true
    }
}
