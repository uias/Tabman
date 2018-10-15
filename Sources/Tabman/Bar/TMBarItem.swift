//
//  TMBarItem.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public struct TMBarItem {
    
    // MARK: Properties
    
    public let title: String?
    public let image: UIImage?
        
    // MARK: Init
    
    public init(title: String) {
        self.init(with: title, image: nil)
    }
    
    public init(image: UIImage) {
        self.init(with: nil, image: image)
    }
    
    public init(title: String, image: UIImage) {
        self.init(with: title, image: image)
    }
    
    private init(with title: String?, image: UIImage?) {
        self.title = title
        self.image = image
    }
}
