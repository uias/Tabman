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
        static let badgeInsets = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 0.0, right: 4.0)
    }
    
    // MARK: Properties
    
    private let label = AnimateableLabel()
    private let imageView = UIImageView()
    
    private var imageWidth: NSLayoutConstraint!
    private var imageHeight: NSLayoutConstraint!
    
    private var componentLayoutView: UIView?
    private var componentConstraints: [NSLayoutConstraint]?
    
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
        componentLayoutView = view
        
        label.textAlignment = .center
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    open override func layoutBadge(_ badge: TMBadgeView, in view: UIView) {
        super.layoutBadge(badge, in: view)
        
        let insets = Defaults.badgeInsets
        view.addSubview(badge)
        badge.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            view.trailingAnchor.constraint(equalTo: badge.trailingAnchor, constant: insets.right)
            ])
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
    
    // MARK: Layout
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if let view = componentLayoutView {
            makeComponentConstraints(for: UIDevice.current.orientation, parent: view)
        }
    }
    
    private func makeComponentConstraints(for orientation: UIDeviceOrientation, parent: UIView) {
        NSLayoutConstraint.deactivate(componentConstraints ?? [])
        
        let constraints: [NSLayoutConstraint]
        if orientation.isLandscape || traitCollection.horizontalSizeClass == .regular {
            
            constraints = [
                imageView.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: Defaults.imagePadding),
                imageView.topAnchor.constraint(equalTo: parent.topAnchor, constant: Defaults.imagePadding),
                parent.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Defaults.imagePadding),
                label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Defaults.imagePadding),
                label.topAnchor.constraint(greaterThanOrEqualTo: parent.topAnchor, constant: Defaults.labelPadding),
                parent.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: Defaults.labelPadding),
                parent.bottomAnchor.constraint(greaterThanOrEqualTo: label.bottomAnchor, constant: Defaults.labelPadding),
                label.centerYAnchor.constraint(equalTo: parent.centerYAnchor)
            ]
            
        } else {
            
            constraints = [
                imageView.topAnchor.constraint(equalTo: parent.topAnchor, constant: Defaults.imagePadding),
                imageView.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
                imageView.leadingAnchor.constraint(greaterThanOrEqualTo: parent.leadingAnchor, constant: Defaults.imagePadding),
                label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Defaults.labelTopPadding),
                label.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: Defaults.labelPadding),
                parent.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: Defaults.labelPadding),
                label.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
            ]
        }
        
        componentConstraints = constraints
        NSLayoutConstraint.activate(constraints)
    }
}
