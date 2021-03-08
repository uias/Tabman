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
        get {
            if let color = textLayer.foregroundColor {
                return UIColor(cgColor: color)
            }
            return .black
        }
        set {
            let textColor = newValue ?? .black
            textLayer.foregroundColor = textColor.cgColor
        }
    }
    var font: UIFont? {
        didSet {
            reloadTextLayerForCurrentFont()
        }
    }
    var textAlignment: NSTextAlignment? {
        didSet {
            textLayer.alignmentMode = caTextLayerAlignmentMode(from: textAlignment) ?? .left
        }
    }
    
    private var _adjustsFontForContentSizeCategory = false
    /// A Boolean that indicates whether the object automatically updates its font when the device's content size category changes.
    ///
    /// Defaults to `false`.
    @available(iOS 11, *)
    var adjustsFontForContentSizeCategory: Bool {
        get {
            _adjustsFontForContentSizeCategory
        }
        set {
            _adjustsFontForContentSizeCategory = newValue
            reloadTextLayerForCurrentFont()
        }
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        textLayer.truncationMode = .end
        textLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(textLayer)
    }
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLayer.frame = bounds
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 10, *) {
            guard traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory else {
                return
            }
            reloadTextLayerForCurrentFont()
        }
    }
    
    private func reloadTextLayerForCurrentFont() {
        if #available(iOS 11, *), adjustsFontForContentSizeCategory, let font = font, let textStyle = font.fontDescriptor.object(forKey: .textStyle) as? UIFont.TextStyle {
            let font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
            textLayer.font = font
            textLayer.fontSize = font.pointSize
        } else {
            textLayer.font = font
            textLayer.fontSize = font?.pointSize ?? 17.0
        }
        invalidateIntrinsicContentSize()
        superview?.setNeedsLayout()
        superview?.layoutIfNeeded()
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
