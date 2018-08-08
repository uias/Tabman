//
//  TabItemBarButton.swift
//  Tabman
//
//  Created by Merrick Sapsford on 02/08/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public final class TabItemBarButton: BarButton {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let imagePadding: CGFloat = 8.0
        static let labelTopPadding: CGFloat = 8.0
        static let imageSize = CGSize(width: 30.0, height: 30.0)
    }
    
    // MARK: Properties
    
    private let label = UILabel()
    private let imageView = UIImageView()
    
    private var imageWidth: NSLayoutConstraint!
    private var imageHeight: NSLayoutConstraint!
    
    // MARK: Lifecycle
    
    public override func performLayout(in view: UIView) {
        super.performLayout(in: view)
        
        label.textAlignment = .center
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // core layout
        let constraints = [
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Defaults.imagePadding),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: Defaults.imagePadding),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Defaults.labelTopPadding),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        // set image size
        self.imageWidth = imageView.widthAnchor.constraint(equalToConstant: Defaults.imageSize.width)
        self.imageHeight = imageView.heightAnchor.constraint(equalToConstant: Defaults.imageSize.height)
        imageWidth.isActive = true
        imageHeight.isActive = true
        
        imageView.backgroundColor = .lightGray
        label.text = "Item"
    }
}

public extension TabItemBarButton {
    
    public var imageSize: CGSize {
        set {
            imageWidth.constant = newValue.width
            imageHeight.constant = newValue.height
        } get {
            return CGSize(width: imageWidth.constant, height: imageHeight.constant)
        }
    }
}
