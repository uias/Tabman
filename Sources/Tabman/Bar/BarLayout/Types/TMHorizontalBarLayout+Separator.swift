//
//  TMHorizontalBarLayout+Separator.swift
//  Tabman
//
//  Created by Merrick Sapsford on 28/04/2019.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

extension TMHorizontalBarLayout {
    
    internal class SeparatorView: UIView {
        
        // swiftlint:disable nesting
        
        private struct Defaults {
            static let width: CGFloat = 1.0
            static let contentInset = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 4.0, right: 0.0)
        }
        
        // MARK: Properties
        
        private let content = UIView()
        
        @available (*, unavailable)
        override var backgroundColor: UIColor? {
            didSet {}
        }
        
        override var tintColor: UIColor! {
            didSet {
                content.backgroundColor = tintColor
            }
        }
        
        private var contentWidth: NSLayoutConstraint?
        private var _width: CGFloat?
        var width: CGFloat! {
            get {
                return _width ?? Defaults.width
            }
            set {
                _width = newValue
                contentWidth?.constant = width
            }
        }
        
        private var contentLeading: NSLayoutConstraint?
        private var contentTop: NSLayoutConstraint?
        private var contentTrailing: NSLayoutConstraint?
        private var contentBottom: NSLayoutConstraint?
        private var _contentInset: UIEdgeInsets?
        var contentInset: UIEdgeInsets! {
            get {
                return _contentInset ?? Defaults.contentInset
            }
            set {
                _contentInset = newValue
                contentLeading?.constant = contentInset.left
                contentTop?.constant = contentInset.top
                contentTrailing?.constant = contentInset.right
                contentBottom?.constant = contentInset.bottom
            }
        }
        
        // MARK: Init
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            initialize()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            initialize()
        }
        
        private func initialize() {
            
            content.translatesAutoresizingMaskIntoConstraints = false
            addSubview(content)
            
            let leading = content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentInset.left)
            let top = content.topAnchor.constraint(equalTo: topAnchor, constant: contentInset.top)
            let trailing = trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: contentInset.right)
            let bottom = bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: contentInset.bottom)
            NSLayoutConstraint.activate([
                leading,
                top,
                trailing,
                bottom
                ])
            contentLeading = leading
            contentTop = top
            contentTrailing = trailing
            contentBottom = bottom
            
            contentWidth = content.widthAnchor.constraint(equalToConstant: width)
            contentWidth?.isActive = true
            
            content.backgroundColor = tintColor
        }
    }
}
