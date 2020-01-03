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
        static let badgeLeadingInset: CGFloat = 8.0
    }
    
    // MARK: Types
    
    /// Vertical alignment of the label within the bar button.
    ///
    /// - `.center`: Center the label vertically in the button.
    /// - `.top`: Align the label with the top of the button.
    /// - `.bottom`: Align the label with the bottom of the button.
    public enum VerticalAlignment {
        case center
        case top
        case bottom
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
    private let badgeContainer = UIView()
    private var badgeContainerLeading: NSLayoutConstraint?
    private var badgeContainerWidth: NSLayoutConstraint?
    
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
    
    /// How to vertically align the label within the button. Defaults to `.center`.
    ///
    /// - Note: This will only apply when the button is larger than
    /// the required intrinsic height. If the bar sizes itself intrinsically,
    /// setting this paramter will have no effect.
    open var verticalAlignment: VerticalAlignment = .center {
        didSet {
            updateAlignmentConstraints()
        }
    }
    private var labelTopConstraint: NSLayoutConstraint?
    private var labelCenterConstraint: NSLayoutConstraint?
    private var labelBottomConstraint: NSLayoutConstraint?
    
    // MARK: Lifecycle
    
    open override func layout(in view: UIView) {
        super.layout(in: view)
        
        view.addSubview(label)
        view.addSubview(badgeContainer)
        label.translatesAutoresizingMaskIntoConstraints = false
        badgeContainer.translatesAutoresizingMaskIntoConstraints = false
        let badgeContainerLeading = badgeContainer.leadingAnchor.constraint(equalTo: label.trailingAnchor)
        let badgeContainerWidth = badgeContainer.widthAnchor.constraint(equalToConstant: 0.0)
        let labelCenterConstraint = label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let constraints = [
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            view.bottomAnchor.constraint(greaterThanOrEqualTo: label.bottomAnchor),
            labelCenterConstraint,
            badgeContainerLeading,
            badgeContainer.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: badgeContainer.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: badgeContainer.bottomAnchor),
            badgeContainerWidth
        ]
        self.badgeContainerLeading = badgeContainerLeading
        self.badgeContainerWidth = badgeContainerWidth
        
        self.labelCenterConstraint = labelCenterConstraint
        self.labelTopConstraint = label.topAnchor.constraint(equalTo: view.topAnchor)
        self.labelBottomConstraint = view.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        
        NSLayoutConstraint.activate(constraints)
        
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        adjustsAlphaOnSelection = false
        label.text = Defaults.text
        label.font = self.font
        if #available(iOS 13, *) {
            tintColor = .label
        } else {
            tintColor = .black
        }
        selectedTintColor = .systemBlue
        contentInset = Defaults.contentInset
        
        calculateFontIntrinsicContentSize(for: label.text)
    }
    
    open override func layoutBadge(_ badge: TMBadgeView, in view: UIView) {
        super.layoutBadge(badge, in: view)
        
        badgeContainer.addSubview(badge)
        badge.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            badge.leadingAnchor.constraint(equalTo: badgeContainer.leadingAnchor),
            badge.topAnchor.constraint(greaterThanOrEqualTo: badgeContainer.topAnchor),
            badgeContainer.bottomAnchor.constraint(greaterThanOrEqualTo: badge.bottomAnchor),
            badge.centerYAnchor.constraint(equalTo: badgeContainer.centerYAnchor)
            ])
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        UIView.performWithoutAnimation {
            update(for: selectionState)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        badge.layoutIfNeeded()
        updateBadgeConstraints()
    }
    
    open override func populate(for item: TMBarItemable) {
        super.populate(for: item)
        
        label.text = item.title
        calculateFontIntrinsicContentSize(for: item.title)
    
        updateBadgeConstraints()
    }
    
    open override func update(for selectionState: TMBarButton.SelectionState) {
        super.update(for: selectionState)
        
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
    
    // MARK: Layout
    
    private func updateBadgeConstraints() {
        let isBadgeVisible = badge.value != nil
        badgeContainerWidth?.constant =  isBadgeVisible ? badge.bounds.size.width : 0.0
        badgeContainerLeading?.constant = isBadgeVisible ? Defaults.badgeLeadingInset : 0.0
    }
    
    private func updateAlignmentConstraints() {
        switch verticalAlignment {
        case .center:
            labelCenterConstraint?.isActive = true
            labelTopConstraint?.isActive = false
            labelBottomConstraint?.isActive = false
        case .top:
            labelCenterConstraint?.isActive = false
            labelTopConstraint?.isActive = true
            labelBottomConstraint?.isActive = false
        case .bottom:
            labelCenterConstraint?.isActive = false
            labelTopConstraint?.isActive = false
            labelBottomConstraint?.isActive = true
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
