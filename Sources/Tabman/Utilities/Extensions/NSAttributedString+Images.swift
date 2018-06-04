//
//  NSAttributedString+Images.swift
//  Tabman
//
//  Created by Ryan Zulkoski on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

extension NSAttributedString {

    /// Returns an attributed string containing the supplied image as a text attachment.
    /// If a height is specified the image will be scaled proportionally to fit, otherwise the image size will be assumed.
    ///
    /// [Read more](https://www.hackingwithswift.com/example-code/system/how-to-insert-images-into-an-attributed-string-with-nstextattachment)
    ///
    /// - Parameters:
    ///   - image: The image used to create the text attachment.
    ///   - bounds: The desired bounds of the text attachment. If not specified it will default to origin of zero with the image size.
    convenience init(image: UIImage, withBounds bounds: CGRect?) {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image

        if let bounds = bounds {
            imageAttachment.bounds = bounds
        }

        self.init(attachment: imageAttachment)
    }
}

extension NSMutableAttributedString {

    /// Inserts the characters and attributes of the given attributed string into the beginning of the receiver.
    ///
    /// - parameter attrString: The attributed string to insert.
    func prepend(_ attrString: NSAttributedString) {
        insert(attrString, at: 0)
    }
}
