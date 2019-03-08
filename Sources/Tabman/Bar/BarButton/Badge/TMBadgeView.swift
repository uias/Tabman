//
//  TMBadgeView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/02/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

///
open class TMBadgeView: UIView {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let contentInset = UIEdgeInsets(top: 2.0, left: 4.0, bottom: 2.0, right: 4.0)
        static let font = UIFont.systemFont(ofSize: 11, weight: .bold)
        static let textColor = UIColor.white
        static let tintColor = UIColor.red
    }
    
    // MARK: Properties
    
    private let contentView = UIView()
    private let label = UILabel()
    
    /// Value to display.
    internal var value: String? {
        didSet {
            if value != nil {
                label.text = value
            }
            updateContentVisibility(for: value)
        }
    }
    /// Attributed value to display.
    internal var attributedValue: NSAttributedString? {
        set {
            label.attributedText = newValue
        } get {
            return label.attributedText
        }
    }
    /// Font for the label.
    open var font: UIFont {
        set {
            label.font = newValue
        } get {
            return label.font
        }
    }
    /// Text color of the label.
    open var textColor: UIColor {
        set {
            label.textColor = newValue
        } get {
            return label.textColor
        }
    }
    /// Tint which is used as background color.
    open override var tintColor: UIColor! {
        didSet {
            contentView.backgroundColor = tintColor
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
        
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        
        let contentInset = Defaults.contentInset
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentInset.left),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentInset.top),
            contentView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: contentInset.right),
            contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: contentInset.bottom)
            ])
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(greaterThanOrEqualTo: heightAnchor)
            ])
        
        label.textAlignment = .center
        label.font = Defaults.font
        label.textColor = Defaults.textColor
        tintColor = Defaults.tintColor
        
        label.text = "."
        updateContentVisibility(for: nil)
    }
    
    // MARK: Lifecycle
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = bounds.size.height / 2.0
    }
    
    // MARK: Animations
    
    private func updateContentVisibility(for value: String?) {
        switch value {
        case .none: // hidden
            guard contentView.alpha == 1.0 else {
                return
            }
            contentView.alpha = 0.0
            contentView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            
        case .some: // visible
            guard contentView.alpha == 0.0 else {
                return
            }
            contentView.alpha = 1.0
            contentView.transform = .identity
        }
    }
}
