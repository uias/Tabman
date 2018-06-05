//
//  UIView+Screenshot.swift
//  Tabman
//
//  Created by Ryan Zulkoski on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

extension UIView {

    /// Returns an image base on the current contents of the receiver.
    func screenshot() -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
        }

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image ?? UIImage()
    }
}
