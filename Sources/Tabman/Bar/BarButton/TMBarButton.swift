//
//  TMBarButton.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

open class TMBarButton: UIControl {
    
    // MARK: Types
    
    public enum SelectionState {
        case unselected
        case partial(delta: CGFloat)
        case selected
    }
    
    // MARK: Properties
    
    private let contentView = UIView()
    private var contentViewLeading: NSLayoutConstraint!
    private var contentViewTop: NSLayoutConstraint!
    private var contentViewTrailing: NSLayoutConstraint!
    private var contentViewBottom: NSLayoutConstraint!

    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            contentViewLeading.constant = contentInset.left
            contentViewTop.constant = contentInset.top
            contentViewTrailing.constant = contentInset.right
            contentViewBottom.constant = contentInset.bottom
        }
    }
    
    public var selectionState: SelectionState = .unselected {
        didSet {
            self.isSelected = selectionState == .selected
            update(for: selectionState)
        }
    }
    
    public let background = BarBackground()
    
    // MARK: Init
    
    public required init() {
        super.init(frame: .zero)
        initialize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        
        addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.topAnchor.constraint(equalTo: topAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        contentView.isUserInteractionEnabled = false
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentViewLeading = contentView.leadingAnchor.constraint(equalTo: leadingAnchor)
        contentViewTop = contentView.topAnchor.constraint(equalTo: topAnchor)
        contentViewTrailing = trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        contentViewBottom = bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        NSLayoutConstraint.activate([contentViewLeading, contentViewTop, contentViewTrailing, contentViewBottom])
        
        layout(in: contentView)
    }
    
    // MARK: Lifecycle
    
    open func layout(in view: UIView) {
    }
    
    open func populate(for item: TMBarItem) {
    }
    
    open func update(for selectionState: SelectionState) {
        let minimumAlpha: CGFloat = 0.5
        let alpha = minimumAlpha + (selectionState.rawValue * minimumAlpha)
        
        self.alpha = alpha
    }
}

extension TMBarButton.SelectionState: Equatable {
    
    static func from(rawValue: CGFloat) -> TMBarButton.SelectionState {
        switch rawValue {
        case 0.0:
            return .unselected
        case 1.0:
            return .selected
        default:
            return .partial(delta: rawValue)
        }
    }
    
    var rawValue: CGFloat {
        switch self {
        case .unselected:
            return 0.0
        case .partial(let delta):
            return delta
        case .selected:
            return 1.0
        }
    }
    
    public static func == (lhs: TMBarButton.SelectionState, rhs: TMBarButton.SelectionState) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
