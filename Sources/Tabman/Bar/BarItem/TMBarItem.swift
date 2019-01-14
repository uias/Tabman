//
//  TMBarItem.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

/// Definition of an item that can be displayed in a `TMBar`.
///
/// Properties of a `TMBarItemable` are optionally displayed in a `TMBar` depending on the layout / configuration.
///
/// Tabman adds extensions to UIKit components to natively support `TMBarItemable`, such as `UINavigationItem` and
/// `UITabBarItem`. Therefore for example, simply returning a `UIViewController` `navigationItem` as a `TMBarItemable` is
/// fully supported.
public protocol TMBarItemable: class {
    
    /// Title of the item.
    var title: String? { get }
    /// Image to display.
    var image: UIImage? { get }
}

/// Default `TMBarItemable` that can be displayed in a `TMBar`.
public final class TMBarItem: TMBarItemable {
    
    // MARK: Properties
    
    public let title: String?
    public let image: UIImage?
        
    // MARK: Init
    
    public convenience init(title: String) {
        self.init(with: title, image: nil)
    }
    
    public convenience init(image: UIImage) {
        self.init(with: nil, image: image)
    }
    
    public convenience init(title: String, image: UIImage) {
        self.init(with: title, image: image)
    }
    
    private init(with title: String?, image: UIImage?) {
        self.title = title
        self.image = image
    }
}
