//
//  TMBarItem.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

internal let TMBarItemableNeedsUpdateNotification = Notification.Name(rawValue: "TMBarItemableNeedsUpdateNotification")

/// Definition of an item that can be displayed in a `TMBar`.
///
/// Properties of a `TMBarItemable` are optionally displayed in a `TMBar` depending on the layout / configuration.
///
/// Tabman adds extensions to UIKit components to natively support `TMBarItemable`, such as `UINavigationItem` and
/// `UITabBarItem`. Therefore for example, simply returning a `UIViewController` `navigationItem` as a `TMBarItemable` is
/// fully supported.
public protocol TMBarItemable: AnyObject {
    
    /// Title of the item.
    var title: String? { get set }
    /// Image to display.
    ///
    /// - Note: If you want the image to be colored by tint colors when within a `TMBar`, you must use the `.alwaysTemplate` image rendering mode.
    /// - Warning: The usage of this property is dependent on the type of `TMBarButton` within the bar.
    var image: UIImage? { get set }
    
    /// Image for the selected state.
    ///
    /// - Warning: The usage of this property is dependent on the type of `TMBarButton` within the bar.
    var selectedImage: UIImage? { get set }
    
    /// Badge value to display.
    var badgeValue: String? { get set }

    /// Returns a short description of the button.
    var accessibilityLabel: String? { get set }

    /// A brief description of the result of performing an action on the accessibility element, in a localized string.
    var accessibilityHint: String? { get set }
    
    /// Inform the bar that the item has been updated.
    ///
    /// This will notify any button that is responsible for the item
    /// that it requires updating, and will call `populate(for: item)`.
    /// The bar indicator position will also be reloaded to reflect any
    /// layout updates.
    func setNeedsUpdate()
}

extension TMBarItemable {
    
    public func setNeedsUpdate() {
        NotificationCenter.default.post(name: TMBarItemableNeedsUpdateNotification, object: self)
    }
}

/// :nodoc:
extension TMBarItemable {
    
    // swiftlint:disable unused_setter_value

    public var accessibilityLabel: String? {
        get {
            return nil
        }
        set {}
    }
    
    public var accessibilityHint: String? {
        get {
            return nil
        }
        set {}
    }
}

/// Default `TMBarItemable` that can be displayed in a `TMBar`.
open class TMBarItem: TMBarItemable {
    
    // MARK: Properties
    
    open var title: String? {
        didSet  {
            setNeedsUpdate()
        }
    }
    
    open var image: UIImage?  {
        didSet {
            setNeedsUpdate()
        }
    }
    
    open var selectedImage: UIImage?  {
        didSet {
            setNeedsUpdate()
        }
    }
    
    open var badgeValue: String? {
        didSet {
            setNeedsUpdate()
        }
    }

    public var accessibilityLabel: String? {
        didSet {
            setNeedsUpdate()
        }
    }

    public var accessibilityHint: String? {
        didSet {
            setNeedsUpdate()
        }
    }

    public var isAccessibilityElement: Bool { return true }
        
    // MARK: Init
    
    /// Create an Item with a title.
    ///
    /// - Parameters:
    ///   - title: Title of the item.
    ///   - badgeValue: Badge value to display.
    public convenience init(title: String, badgeValue: String? = nil) {
        self.init(with: title, image: nil, selectedImage: nil, badgeValue: badgeValue)
    }
    
    /// Create an Item with an image.
    ///
    /// - Parameters:
    ///   - image: Image of the item.
    ///   - selectedImage: Image of the item when selected.
    ///   - badgeValue: Badge value to display.
    public convenience init(image: UIImage, selectedImage: UIImage? = nil, badgeValue: String? = nil) {
        self.init(with: nil, image: image, selectedImage: selectedImage, badgeValue: badgeValue)
    }
    
    /// Create an Item with a title and an image.
    ///
    /// - Parameters:
    ///   - title: Title of the item.
    ///   - image: Image of the item.
    ///   - selectedImage: Image of the item when selected.
    ///   - badgeValue: Badge value to display.
    public convenience init(title: String, image: UIImage, selectedImage: UIImage? = nil, badgeValue: String? = nil) {
        self.init(with: title, image: image, selectedImage: selectedImage, badgeValue: badgeValue)
    }
    
    private init(with title: String?, image: UIImage?, selectedImage: UIImage?, badgeValue: String?) {
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
        self.badgeValue = badgeValue
    }
}
