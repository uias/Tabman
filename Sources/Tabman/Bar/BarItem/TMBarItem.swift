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
public protocol TMBarItemable: class {
    
    /// Title of the item.
    var title: String? { get set }
    /// Image to display.
    var image: UIImage? { get set }
    
    /// Badge value to display.
    var badgeValue: String? { get set }
    
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

/// Default `TMBarItemable` that can be displayed in a `TMBar`.
public final class TMBarItem: TMBarItemable {
    
    // MARK: Properties
    
    public var title: String? {
        didSet  {
            setNeedsUpdate()
        }
    }
    public var image: UIImage?  {
        didSet {
            setNeedsUpdate()
        }
    }
    
    public var badgeValue: String? {
        didSet {
            setNeedsUpdate()
        }
    }
        
    // MARK: Init
    
    /// Create an Item with a title.
    ///
    /// - Parameters:
    ///   - title: Title of the item.
    ///   - badgeValue: Badge value to display.
    public convenience init(title: String, badgeValue: String? = nil) {
        self.init(with: title, image: nil, badgeValue: badgeValue)
    }
    
    /// Create an Item with an image.
    ///
    /// - Parameters:
    ///   - image: Image of the item.
    ///   - badgeValue: Badge value to display.
    public convenience init(image: UIImage, badgeValue: String? = nil) {
        self.init(with: nil, image: image, badgeValue: badgeValue)
    }
    
    /// Create an Item with a title and an image.
    ///
    /// - Parameters:
    ///   - title: Title of the item.
    ///   - image: Image of the item.
    ///   - badgeValue: Badge value to display.
    public convenience init(title: String, image: UIImage, badgeValue: String? = nil) {
        self.init(with: title, image: image, badgeValue: badgeValue)
    }
    
    private init(with title: String?, image: UIImage?, badgeValue: String?) {
        self.title = title
        self.image = image
        self.badgeValue = badgeValue
    }
}
