//
//  ImageUtils.swift
//  Tabman
//
//  Created by Merrick Sapsford on 14/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resize(toSize size: CGSize) -> UIImage {

        let scale = size.width / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width, height: newHeight),
                                               false,
                                               UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
}
