//
//  LabelBarButton.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

public final class LabelBarButton: BarButton {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let contentInset: UIEdgeInsets = UIEdgeInsets(top: 12.0, left: 8.0, bottom: 12.0, right: 8.0)
    }
    
    // MARK: Properties
    
    private let label = UILabel()
    
    // MARK: Lifecycle
    
    public override func performLayout(in view: UIView) {
        super.performLayout(in: view)
        
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.contentInset = Defaults.contentInset
        label.text = "Label"
    }
    
    override func populate(for item: BarItem) {
        super.populate(for: item)
        
        label.text = item.title
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
