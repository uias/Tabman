//
//  TMTabItemBarButton.swift
//  Tabman
//
//  Created by Merrick Sapsford on 02/08/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

/// `TMBarButton` which mimics appearance of a `UITabBarItem`, containing a image and label vertically aligned.
open class TMTabItemBarButton: TMBarButton {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let imagePadding: CGFloat = 8.0
        static let imageSize = CGSize(width: 30.0, height: 30.0)
        static let labelPadding: CGFloat = 4.0
        static let labelTopPadding: CGFloat = 6.0
        static let shrunkenImageScale: CGFloat = 0.9
    }
    
    // MARK: Properties
    
    private let label = AnimateableLabel()
    private let imageView = UIImageView()
    
    private var imageWidth: NSLayoutConstraint!
    private var imageHeight: NSLayoutConstraint!
    
    // MARK: Customization
    
    /// Tint color of the button when unselected / normal.
    open override var tintColor: UIColor! {
        didSet {
            if !isSelected {
                imageView.tintColor = tintColor
                label.textColor = tintColor
            }
        }
    }
    /// Tint color of the button when selected.
    open var selectedTintColor: UIColor! {
        didSet {
            if isSelected {
                imageView.tintColor = selectedTintColor
                label.textColor = selectedTintColor
            }
        }
    }
    /// Size of the image view.
    open var imageViewSize: CGSize {
        set {
            imageWidth.constant = newValue.width
            imageHeight.constant = newValue.height
        } get {
            return CGSize(width: imageWidth.constant, height: imageHeight.constant)
        }
    }
    /// Font of the text label.
    open var font: UIFont = UIFont.systemFont(ofSize: 12.0, weight: .medium) {
        didSet {
            label.font = font
        }
    }
    /// Content Mode for the image view.
    open var imageContentMode: UIView.ContentMode {
        set {
            imageView.contentMode = newValue
        } get {
            return imageView.contentMode
        }
    }
    /// Whether to shrink the image view when unselected.
    ///
    /// Defaults to true.
    open var shrinksImageWhenUnselected: Bool = true {
        didSet {
            guard shrinksImageWhenUnselected else {
                return
            }
            if !self.isSelected {
                imageView.transform = CGAffineTransform(scaleX: Defaults.shrunkenImageScale, y: Defaults.shrunkenImageScale)
            }
        }
    }
    
    // MARK: Lifecycle
    
    open override func layout(in view: UIView) {
        super.layout(in: view)
        
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
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Defaults.labelPadding),
            view.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: Defaults.labelPadding),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        // set image size
        self.imageWidth = imageView.widthAnchor.constraint(equalToConstant: Defaults.imageSize.width)
        self.imageHeight = imageView.heightAnchor.constraint(equalToConstant: Defaults.imageSize.height)
        imageWidth.isActive = true
        imageHeight.isActive = true
        
        selectedTintColor = tintColor
        tintColor = .black
        label.font = self.font
        label.text = "Item"
    }
    
    open override func populate(for item: TMBarItemable) {
        super.populate(for: item)
        
        label.text = item.title
        imageView.image = item.image
    }
    
    open override func update(for selectionState: TMBarButton.SelectionState) {
        super.update(for: selectionState)
        
        let transitionColor = tintColor.interpolate(with: selectedTintColor,
                                                percent: selectionState.rawValue)
        imageView.tintColor = transitionColor
        label.textColor = transitionColor
        
        if shrinksImageWhenUnselected {
            let interpolatedScale = 1.0 - ((1.0 - selectionState.rawValue) * (1.0 - Defaults.shrunkenImageScale))
            imageView.transform = CGAffineTransform(scaleX: interpolatedScale, y: interpolatedScale)
        }
    }
}
