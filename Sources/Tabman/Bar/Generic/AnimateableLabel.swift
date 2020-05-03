//
//  AnimateableLabel.swift
//  Tabman
//
//  Created by Merrick Sapsford on 09/11/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit
import QuartzCore

internal class AnimateableLabel: UIView {
    
    // MARK: Properties
    
    override var intrinsicContentSize: CGSize {
        return textLayer.preferredFrameSize()
    }
    
    private let textLayer = CATextLayer()
    
    var text: String? {
        didSet {
            textLayer.string = text
            invalidateIntrinsicContentSize()
        }
    }
    var textColor: UIColor! {
        set {
            let textColor = newValue ?? .black
            textLayer.foregroundColor = textColor.cgColor
        } get {
            if let color = textLayer.foregroundColor {
                return UIColor(cgColor: color)
            }
            return .black
        }
    }
    var font: UIFont? {
        didSet {
            textLayer.font = font
            textLayer.fontSize = font?.pointSize ?? 17.0
            invalidateIntrinsicContentSize()
            superview?.setNeedsLayout()
            superview?.layoutIfNeeded()
        }
    }
    var textAlignment: NSTextAlignment? {
        didSet {
            textLayer.alignmentMode = caTextLayerAlignmentMode(from: textAlignment) ?? .left
        }
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        
        textLayer.truncationMode = .end
        textLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(textLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLayer.frame = bounds
    }
}

private extension AnimateableLabel {
    
    func caTextLayerAlignmentMode(from alignment: NSTextAlignment?) -> CATextLayerAlignmentMode? {
        guard let alignment = alignment else {
            return nil
        }
        switch alignment {
        case .center:
            return .center
        case .justified:
            return .justified
        case .natural:
            return .natural
        case .right:
            return .right
        default:
            return .left
        }
    }
}
