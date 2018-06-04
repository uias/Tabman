//
//  BadgeSwift+Appearance.swift
//  Tabman
//
//  Created by Ryan Zulkoski on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import BadgeSwift

extension BadgeSwift {

    func applyAppearance(_ appearance: TabmanBar.Appearance) {
        let badge = appearance.badge
        let defaultBadge = TabmanBar.Appearance.defaultAppearance.badge

        font = badge.font ?? defaultBadge.font!
        textColor = badge.textColor ?? defaultBadge.textColor!
        badgeColor = badge.badgeColor ?? defaultBadge.badgeColor!
        insets = badge.insets ?? defaultBadge.insets!
        borderWidth = badge.borderWidth ?? defaultBadge.borderWidth!
        borderColor = badge.borderColor ?? defaultBadge.borderColor!

        switch badge.cornerRadius ?? defaultBadge.cornerRadius! {
        case .fullyRounded: cornerRadius = -1.0
        case .square: cornerRadius = 0.0
        case .custom(let value): cornerRadius = value
        }
    }
}

extension UIButton {

    func setAttributedTitle(_ title: String, badgeText: String, appearance: TabmanBar.Appearance) {

        // Create badge
        let badge = BadgeSwift(frame: .zero)
        badge.text = badgeText
        badge.applyAppearance(appearance)

        // Create image of current badge state
        badge.sizeToFit()
        let image = badge.screenshot()

        let defaultAppearance = TabmanBar.Appearance.defaultAppearance
        let textFont = appearance.text.font ?? defaultAppearance.text.font!
        let color = appearance.state.color ?? defaultAppearance.state.color!
        let textSelectedFont = appearance.text.selectedFont ?? defaultAppearance.text.selectedFont ?? textFont
        let selectedColor = appearance.state.selectedColor ?? defaultAppearance.state.selectedColor ?? color

        // Create attributed strings representing the title in the normal and selected states
        let attributedTitle = NSMutableAttributedString(string: title, attributes: [.font: textFont, .foregroundColor: color])
        let attributedSelectedTitle = NSMutableAttributedString(string: title, attributes: [.font: textSelectedFont, .foregroundColor: selectedColor])

        for attributedString in [attributedTitle, attributedSelectedTitle] {

            // Create a string to create the desired amount of spacing between the title text and the badge
            let spacing = appearance.badge.spacing ?? defaultAppearance.badge.spacing!
            let spacingString = NSAttributedString(string: " ", attributes: [.font: UIFont.systemFont(ofSize: 0), .kern: spacing])

            // Create a string containing the image as a text attachment and align it vertically with the center of the title text
            let desiredImageY: CGFloat = textFont.descender + textFont.lineHeight/2 - image.size.height/2
            let imageString = NSAttributedString(image: image, withBounds: CGRect(origin: CGPoint(x: 0, y: desiredImageY), size: image.size))

            // Attach the spacing and image strings to the desired position relative to the title string
            let append = (appearance.badge.position ?? defaultAppearance.badge.position!) == .trailing
            append ? attributedString.append(spacingString) : attributedString.prepend(spacingString)
            append ? attributedString.append(imageString) : attributedString.prepend(imageString)
        }

        // Set the attributed strings for the normal and selected states on the button
        self.setAttributedTitle(attributedTitle, for: .normal)
        self.setAttributedTitle(attributedSelectedTitle, for: .selected)

        // Disable resizing the title text to fit when a badge is present
        titleLabel?.adjustsFontSizeToFitWidth = false
    }
}
