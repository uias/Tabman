//
//  LabelBarButton.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public final class LabelBarButton: BarButton {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let contentInset: UIEdgeInsets = UIEdgeInsets(top: 12.0, left: 8.0, bottom: 12.0, right: 8.0)
    }
    
    // MARK: Properties
    
    private let label = UILabel()
    
    public var color: UIColor = .black
    public var selectedColor: UIColor = UIView.defaultTintColor
    
    // MARK: Lifecycle
    
    public override func performLayout(in view: UIView) {
        super.performLayout(in: view)
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            view.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            view.topAnchor.constraint(equalTo: label.topAnchor),
            view.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        label.text = "Item"
        
        self.contentInset = Defaults.contentInset
    }
    
    public override func populate(for item: BarItem) {
        super.populate(for: item)
        
        label.text = item.title
    }
    
    public override func update(for selectionState: BarButton.SelectionState) {
        
        let transitionColor = color.interpolate(with: selectedColor,
                                                percent: selectionState.rawValue)
        label.textColor = transitionColor
    }
}

// MARK: - Label manipulation
public extension LabelBarButton {
    
    public var text: String? {
        set {
            label.text = newValue
        } get {
            return label.text
        }
    }
}
