//
//  TMTabItemBarButton.swift
//  Tabman
//
//  Created by Merrick Sapsford on 02/08/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
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
        static let badgeInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 0.0, right: 4.0)
    }
    
    // MARK: Properties
    
    private let container = UIView()
    private let label = AnimateableLabel()
    private let imageView = UIImageView()
    private let selectedImageView = UIImageView()
    
    private var imageWidth: NSLayoutConstraint!
    private var imageHeight: NSLayoutConstraint!
    
    private var componentConstraints: [NSLayoutConstraint]?
    
    // MARK: Customization
    
    /// Tint color of the button when unselected / normal.
    open override var tintColor: UIColor! {
        didSet {}
    }
    /// Tint color of the button when selected.
    open var selectedTintColor: UIColor! {
        didSet {
            selectedImageView.tintColor = selectedTintColor
            if isSelected {
                label.textColor = selectedTintColor
            }
        }
    }
    /// Size of the image view.
    open var imageViewSize: CGSize {
        get {
            return CGSize(width: imageWidth.constant, height: imageHeight.constant)
        }
        set {
            imageWidth.constant = newValue.width
            imageHeight.constant = newValue.height
        }
    }
    /// Font of the text label.
    open var font: UIFont! {
        didSet {
            label.font = font
        }
    }
    /// A Boolean that indicates whether the object automatically updates its font when the device's content size category changes.
    ///
    /// Defaults to `false`.
    @available(iOS 11, *)
    open var adjustsFontForContentSizeCategory: Bool {
        get {
            label.adjustsFontForContentSizeCategory
        }
        set {
            label.adjustsFontForContentSizeCategory = newValue
        }
    }
    /// Content Mode for the image view.
    open var imageContentMode: UIView.ContentMode {
        get {
            return imageView.contentMode
        }
        set {
            imageView.contentMode = newValue
            selectedImageView.contentMode = newValue
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
    
    // MARK: Init

    public required init(for item: TMBarItemable, intrinsicSuperview: UIView?) {
        super.init(for: item, intrinsicSuperview: intrinsicSuperview)

        // On iOS 13 the system dynamically adjusts tab bar item layouts based on orientation -
        // Tabman mimics this here.
        if #available(iOS 13, *) {
            makeComponentConstraints(for: UIDevice.current.orientation)
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Lifecycle
    
    open override func layout(in view: UIView) {
        super.layout(in: view)
        
        view.addSubview(container)
        container.addSubview(imageView)
        container.addSubview(selectedImageView)
        container.addSubview(label)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        // set image size
        self.imageWidth = imageView.widthAnchor.constraint(equalToConstant: Defaults.imageSize.width)
        self.imageHeight = imageView.heightAnchor.constraint(equalToConstant: Defaults.imageSize.height)
        imageWidth.isActive = true
        imageHeight.isActive = true
        
        if #available(iOS 13, *) {
            tintColor = .label
        } else {
            tintColor = .black
        }
        selectedTintColor = .systemBlue
        font = defaultFont(for: .current)
        label.text = "Item"
        label.textAlignment = .center
        adjustsAlphaOnSelection = false
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        makeComponentConstraints(for: UIDevice.current.orientation)

        UIView.performWithoutAnimation {
            update(for: selectionState)
        }
    }
    
    open override func layoutBadge(_ badge: TMBadgeView, in view: UIView) {
        super.layoutBadge(badge, in: view)
        
        let insets = Defaults.badgeInsets
        view.addSubview(badge)
        badge.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top)
            ])
    }
    
    open override func populate(for item: TMBarItemable) {
        super.populate(for: item)
        
        label.text = item.title
        imageView.image = item.image
        selectedImageView.image = item.selectedImage ?? item.image
    }
    
    open override func update(for selectionState: TMBarButton.SelectionState) {
        super.update(for: selectionState)
        
        selectedImageView.alpha = selectionState.rawValue
        imageView.alpha = 1 - selectionState.rawValue
        label.textColor = tintColor.interpolate(with: selectedTintColor, percent: selectionState.rawValue)
        
        if shrinksImageWhenUnselected {
            let interpolatedScale = 1.0 - ((1.0 - selectionState.rawValue) * (1.0 - Defaults.shrunkenImageScale))
            imageView.transform = CGAffineTransform(scaleX: interpolatedScale, y: interpolatedScale)
            selectedImageView.transform = CGAffineTransform(scaleX: interpolatedScale, y: interpolatedScale)
        }
    }

    open override func tintColorDidChange() {
        super.tintColorDidChange()
        
        imageView.tintColor = tintColor
        if !isSelected {
            imageView.tintColor = tintColor
            label.textColor = tintColor
        }
    }
    
    // MARK: Layout
    
    private func makeComponentConstraints(for orientation: UIDeviceOrientation) {
        guard let parent = container.superview else {
            return
        }
        NSLayoutConstraint.deactivate(componentConstraints ?? [])
        
        let constraints: [NSLayoutConstraint]
        
        // If landscape or we are a `.regular` size class
        // Translates to:  Landscape || iPad
        // Tab views will be aligned horizontally.
        if orientation.isLandscape || traitCollection.horizontalSizeClass == .regular {
            
            let imagePadding = traitCollection.horizontalSizeClass == .compact ? Defaults.imagePadding / 2 : Defaults.imagePadding
            let labelPadding = Defaults.labelPadding
            
            constraints = makeHorizontalAlignedConstraints(in: parent,
                                                           imagePadding: imagePadding,
                                                           labelPadding: labelPadding)
        } else { // Default (Portrait on compact) - Vertical alignment
            
            let imagePadding = Defaults.imagePadding
            let labelPadding =  Defaults.labelPadding
            
            constraints = makeVerticalAlignedConstraints(in: parent,
                                                         imagePadding: imagePadding,
                                                         labelPadding: labelPadding)
        }
        
        componentConstraints = constraints
        NSLayoutConstraint.activate(constraints)
    }
    
    private func makeHorizontalAlignedConstraints(in parent: UIView,
                                                  imagePadding: CGFloat,
                                                  labelPadding: CGFloat) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        // Container
        constraints.append(contentsOf: [
            container.leadingAnchor.constraint(greaterThanOrEqualTo: parent.leadingAnchor),
            container.topAnchor.constraint(greaterThanOrEqualTo: parent.topAnchor),
            parent.trailingAnchor.constraint(greaterThanOrEqualTo: container.trailingAnchor),
            parent.bottomAnchor.constraint(greaterThanOrEqualTo: container.bottomAnchor),
            container.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
            container.centerYAnchor.constraint(greaterThanOrEqualTo: parent.centerYAnchor)
            ])
        
        // Label / Image
        let labelViewLeading = label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: labelPadding)
        labelViewLeading.priority = .init(999)
        constraints.append(contentsOf: [
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: imagePadding),
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: imagePadding),
            selectedImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            selectedImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            selectedImageView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            selectedImageView.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            container.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: imagePadding),
            labelViewLeading,
            label.topAnchor.constraint(greaterThanOrEqualTo: container.topAnchor, constant: labelPadding),
            container.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: labelPadding),
            container.bottomAnchor.constraint(greaterThanOrEqualTo: label.bottomAnchor, constant: labelPadding),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
            ])
        
        // Badge
        let badgeInsets = Defaults.badgeInsets
        constraints.append(contentsOf: [
            badge.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: badgeInsets.left)
            ])
        
        return constraints
    }
    
    private func makeVerticalAlignedConstraints(in parent: UIView,
                                                imagePadding: CGFloat,
                                                labelPadding: CGFloat) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        // Container
        constraints.append(contentsOf: [
            container.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            container.topAnchor.constraint(greaterThanOrEqualTo: parent.topAnchor),
            parent.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            parent.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
        
        // Label / Image
        let labelTrailing = container.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: labelPadding)
        labelTrailing.priority = .init(999)
        let imageViewLeading = imageView.leadingAnchor.constraint(greaterThanOrEqualTo: container.leadingAnchor, constant: imagePadding)
        imageViewLeading.priority = .init(999)
        constraints.append(contentsOf: [
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: imagePadding),
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            selectedImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            selectedImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            selectedImageView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            selectedImageView.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            imageViewLeading,
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Defaults.labelTopPadding),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: labelPadding),
            labelTrailing,
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
        
        // Badge
        let badgeInsets = Defaults.badgeInsets
        constraints.append(contentsOf: [
            parent.trailingAnchor.constraint(equalTo: badge.trailingAnchor, constant: badgeInsets.right)
            ])
        
        return constraints
    }
}

extension TMTabItemBarButton {
    
    private func defaultFont(for device: UIDevice) -> UIFont {
        switch device.userInterfaceIdiom {
        case .pad:
            return UIFont.preferredFont(forTextStyle: .caption1)
        default:
            return UIFont.preferredFont(forTextStyle: .caption2)
        }
    }
}
