//
//  TMLabelBarButton.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

/// `TMBarButton` that consists of a single label - that's it!
///
/// Probably the most commonly seen example of a bar button.
open class TMLabelBarButton: TMBarButton {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let contentInset = UIEdgeInsets(top: 12.0, left: 0.0, bottom: 12.0, right: 0.0)
        static let font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        static let text = "Item"
    }
    
    // MARK: Properties
    
    open override var intrinsicContentSize: CGSize {
        if let fontIntrinsicContentSize = self.fontIntrinsicContentSize {
            return fontIntrinsicContentSize
        }
        return super.intrinsicContentSize
    }
    private var fontIntrinsicContentSize: CGSize?
    
    private let label = AnimateableLabel()
    
    open override var contentInset: UIEdgeInsets {
        set {
            super.contentInset = newValue
            calculateFontIntrinsicContentSize(for: text)
        } get {
            return super.contentInset
        }
    }
    
    /// Text to display in the button.
    open var text: String? {
        set {
            label.text = newValue
        } get {
            return label.text
        }
    }
    /// Color of the text when unselected / normal.
    open override var tintColor: UIColor! {
        didSet {
            if !isSelected {
                label.textColor = tintColor
            }
        }
    }
    /// Color of the text when selected.
    open var selectedTintColor: UIColor! {
        didSet {
            if isSelected  {
                label.textColor = selectedTintColor
            }
        }
    }
    /// Font of the text when unselected / normal.
    open var font: UIFont = Defaults.font {
        didSet {
            calculateFontIntrinsicContentSize(for: text)
            if !isSelected || selectedFont == nil {
                label.font = font
            }
        }
    }
    /// Font of the text when selected.
    open var selectedFont: UIFont? {
        didSet {
            calculateFontIntrinsicContentSize(for: text)
            guard let selectedFont = self.selectedFont, isSelected else {
                return
            }
            label.font = selectedFont
        }
    }
    
    // MARK: Lifecycle
    
    open override func layout(in view: UIView) {
        super.layout(in: view)
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            view.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            view.topAnchor.constraint(equalTo: label.topAnchor),
            view.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        label.textAlignment = .center
        
        label.text = Defaults.text
        label.font = self.font
        selectedTintColor = tintColor
        tintColor = .black
        self.contentInset = Defaults.contentInset
        
        calculateFontIntrinsicContentSize(for: label.text)
    }
    
    open override func populate(for item: TMBarItemable) {
        super.populate(for: item)
        
        label.text = item.title
        calculateFontIntrinsicContentSize(for: item.title)
    }
    
    open override func update(for selectionState: TMBarButton.SelectionState) {
        
        let transitionColor = tintColor.interpolate(with: selectedTintColor,
                                                    percent: selectionState.rawValue)
        
        label.textColor = transitionColor
        
        // Because we can't animate nicely between fonts 😩
        // Cross dissolve on 'end' states between font properties.
        if let selectedFont = self.selectedFont {
            if selectionState == .selected && label.font != selectedFont {
                UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.label.font = self.selectedFont
                }, completion: nil)
            } else if selectionState != .selected && label.font == selectedFont {
                UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.label.font = self.font
                }, completion: nil)
            }
        }
    }
}

private extension TMLabelBarButton {
    
    /// Calculates an intrinsic content size based on font properties.
    ///
    /// Make the intrinsic size a calculated size based off a
    /// string value and font that requires the biggest size from `.font` and `.selectedFont`.
    ///
    /// - Parameter string: Value used for calculation.
    private func calculateFontIntrinsicContentSize(for string: String?) {
        guard let value = string else {
            return
        }
        let string = value as NSString
        let font = self.font
        let selectedFont = self.selectedFont ?? self.font
        
        let fontRect = string.boundingRect(with: .zero, options: .usesFontLeading, attributes: [.font: font], context: nil)
        let selectedFontRect = string.boundingRect(with: .zero, options: .usesFontLeading, attributes: [.font: selectedFont], context: nil)
        
        var largestWidth = max(selectedFontRect.size.width, fontRect.size.width)
        var largestHeight = max(selectedFontRect.size.height, fontRect.size.height)
        
        largestWidth += contentInset.left + contentInset.right
        largestHeight += contentInset.top + contentInset.bottom
        
        self.fontIntrinsicContentSize = CGSize(width: largestWidth, height: largestHeight)
        invalidateIntrinsicContentSize()
    }
}

private extension TMLabelBarButton {
    
    func makeTextLayer(for label: UILabel) -> CATextLayer {
        let layer = CATextLayer()
        layer.frame = label.convert(label.frame, to: self)
        layer.string = label.text
        layer.font = label.font
        layer.fontSize = label.font.pointSize
        return layer
    }
}
