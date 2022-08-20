//
//  TMBarViewContentInsetGuides.swift
//  Tabman
//
//  Created by Merrick Sapsford on 01/08/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

/// Content Inset guides for a bar view.
///
/// Contains layout guides for content views taking any contentInset into account.
internal final class TMBarViewContentInsetGuides: TMBarLayoutInsetGuides {
    
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
    
    init<Layout, Button, Indicator>(for barView: TMBarView<Layout, Button, Indicator>) {
        barView.addLayoutGuide(leadingInset)
        barView.addLayoutGuide(content)
        barView.addLayoutGuide(trailingInset)
        
        leadingWidth = leadingInset.widthAnchor.constraint(equalToConstant: insets.left)
        trailingWidth = trailingInset.widthAnchor.constraint(equalToConstant: insets.right)
        
        NSLayoutConstraint.activate([
            leadingInset.leadingAnchor.constraint(equalTo: barView.safeAreaLeadingAnchor),
            leadingInset.topAnchor.constraint(equalTo: barView.topAnchor),
            content.leadingAnchor.constraint(equalTo: leadingInset.trailingAnchor),
            content.topAnchor.constraint(equalTo: barView.topAnchor),
            content.trailingAnchor.constraint(equalTo: trailingInset.leadingAnchor),
            trailingInset.trailingAnchor.constraint(equalTo: barView.safeAreaTrailingAnchor),
            trailingInset.topAnchor.constraint(equalTo: barView.topAnchor),
            leadingWidth,
            trailingWidth
        ])
    }
}
