//
//  String+SizeCalculation.swift
//  Tabman
//
//  Created by Ryan Zulkoski on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

internal extension String {

    /// Calculates the width needed to render the receiver in the given font within the given height.
    /// - Parameters:
    ///    - withConstrainedHeight: The height to use when determining the width.
    ///    - font: The font to use when calculating the width.
    /// - Returns: The width that fits the receiver.
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width * UIScreen.main.scale) / UIScreen.main.scale
    }
}
