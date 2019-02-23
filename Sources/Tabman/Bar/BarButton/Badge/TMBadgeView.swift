//
//  TMBadgeView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/02/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

open class TMBadgeView: UIView {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let contentInset = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        static let font = UIFont.systemFont(ofSize: 12, weight: .medium)
        static let textColor = UIColor.white
    }
    
    // MARK: Properties
    
    private let label = UILabel()
    
    internal var value: String? {
        set {
            label.text = newValue
        } get {
            return label.text
        }
    }
    internal var attributedValue: NSAttributedString? {
        set {
            label.attributedText = newValue
        } get {
            return label.attributedText
        }
    }
    open var font: UIFont {
        set {
            label.font = newValue
        } get {
            return label.font
        }
    }
    open var textColor: UIColor {
        set {
            label.textColor = newValue
        } get {
            return label.textColor
        }
    }
    open override var tintColor: UIColor! {
        didSet {
            backgroundColor = tintColor
        }
    }
    
    // MARK: Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        
        let contentInset = Defaults.contentInset
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentInset.left),
            label.topAnchor.constraint(equalTo: topAnchor, constant: contentInset.top),
            trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: contentInset.right),
            bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: contentInset.bottom)
            ])
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(greaterThanOrEqualTo: heightAnchor)
            ])
        
        label.textAlignment = .center
        label.font = Defaults.font
        label.textColor = Defaults.textColor
        backgroundColor = tintColor
        
        label.text = "1"
    }
    
    // MARK: Lifecycle
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.size.height / 2.0
    }
}
