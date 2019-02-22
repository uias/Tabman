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
        static let contentInset = UIEdgeInsets.zero
    }
    
    // MARK: Properties
    
    private let label = UILabel()
    
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
        label.text = "1"
        backgroundColor = .red
    }
    
    // MARK: Lifecycle
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.size.height / 2.0
    }
}
