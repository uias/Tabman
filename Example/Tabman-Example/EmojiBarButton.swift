//
//  EmojiBarButton.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 17/10/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

private let catalogue = ["⚡️", "🚀", "😁", "🐻", "🤠", "💩", "🐝", "🌝", "🔥", "⭐️", "🍔", "🥃", "🍰", "⚽️", "🎨", "💻"]

struct EmojiBarButton {
    
    let emoji: String
    
    private init(emoji: String) {
        self.emoji = emoji
    }
    
    var image: UIImage {
        let size = CGSize(width: 35, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(rect)
        (emoji as NSString).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension EmojiBarButton {
    
    static func random() -> EmojiBarButton {
        let index = Int.random(in: 0 ..< catalogue.count)
        return EmojiBarButton(emoji: catalogue[index])
    }
}
